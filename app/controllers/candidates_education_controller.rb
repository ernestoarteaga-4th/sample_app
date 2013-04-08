class CandidatesEducationController < ApplicationController
  def index
    @education = CandidatesEducation.find(:all, :include=>"educ_degrees", :conditions=>["candidate_id=?", current_candidate.id])
  end

  def new
    @education = CandidatesEducation.new(params[:educations])

    if params[:educations_educ_degrees_id_new] == ""
      degree = EducDegrees.where({:id => [@education.educ_degrees_id]}).first.name
    else
      degree = params[:educations_educ_degrees_id_new]
      cat_degree = EducDegrees.new(:name => degree, :description => degree, :approved_flag => false)
      cat_degree.save!
      @education.educ_degrees_id = cat_degree.id
    end

    @education.candidate_id = current_candidate.id
    @education.degree = degree
    @education.save

    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/resume/education')
  end

  def update_delete
  	@education = CandidatesEducation.new(params[:e])

    if params[:update_button]
      CandidatesEducation.update(@education.id, 
                                 :title => @education.title, 
                                 :educ_degrees_id => @education.educ_degrees_id, 
                                 :degree => EducDegrees.where({:id => [@education.educ_degrees_id]}).first.name, 
                                 :university => @education.university,
                                 :date_in => @education.date_in,
                                 :date_out => @education.date_out)
    elsif params[:delete_button]
      CandidatesEducation.delete(@education.id)
    end
    
    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/resume/education')
  end
end

class CandidateEducationController < ApplicationController
  def index
    @education = CandidateEducation.find(:all, :include=>"educ_degree", :conditions=>["candidate_id=?", current_candidate.id])
  end

  def new
    @education = CandidateEducation.new(params[:educations])

    if params[:educations_educ_degree_id_new] == ""
      degree = EducDegree.where({:id => [@education.educ_degree_id]}).first.name
    else
      degree = params[:educations_educ_degree_id_new]
      cat_degree = EducDegree.new(:name => degree, :description => degree, :approved_flag => false)
      cat_degree.save!
      @education.educ_degree_id = cat_degree.id
    end

    @education.candidate_id = current_candidate.id
    @education.degree = degree
    @education.save

    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/resume/education')
  end

  def update_delete
  	@education = CandidateEducation.new(params[:e])

    if params[:update_button]
      CandidateEducation.update(@education.id, 
                                 :title => @education.title, 
                                 :educ_degree_id => @education.educ_degree_id, 
                                 :degree => EducDegree.where({:id => [@education.educ_degree_id]}).first.name, 
                                 :university => @education.university,
                                 :date_in => @education.date_in,
                                 :date_out => @education.date_out)
    elsif params[:delete_button]
      CandidateEducation.delete(@education.id)
    end
    
    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/resume/education')
  end
end

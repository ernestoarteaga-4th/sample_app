class CandidatesEducationController < ApplicationController
  def index
    @education = CandidatesEducation.where({:candidate_id => [current_candidate.id]}).all
  end

  def new
    @education = CandidatesEducation.new(params[:educations])
    @education.candidate_id = current_candidate.id
    @education.degree = EducDegrees.where({:id => [@education.educ_degrees_id]}).first.name
    @education.save

    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/resume/education')
  end

  def update_delete
  	@education = CandidatesEducation.new(params[:e])

    if params[:update_button]
      CandidatesEducation.update(@education.id, 
      	                         :title => @education.title, 
      	                         :degree => @education.degree, 
      	                         :university => @education.university,
      	                         :date_in => @education.date_in,
      	                         :date_out => @education.date_out)
    elsif params[:delete_button]
      CandidatesEducation.delete(@education.id)
    end
    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/resume/education')
  end
end

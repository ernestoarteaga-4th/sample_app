class ResumeEducationController < ApplicationController
  def index
    @education = Education.where({:candidate_id => [current_candidate.id]}).all
  end

  def new
    puts @new_education.name
    puts @new_education.university
    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/resume/education')
  end
end

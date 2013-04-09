class CandidateEducationController < ApplicationController
  def index
    @education = current_candidate.candidate_education
  end

  def new
    
  end

  def create
    if params[:education_educ_degree_id_new] == ""
      @education = current_candidate.candidate_education.build(params[:education])
      @education.save
    else
      degree = params[:education_educ_degree_id_new]
      cat_degree = EducDegree.new(:name => degree, :description => degree, :approved_flag => false)
      cat_degree.save!
      
      @education = current_candidate.candidate_education.build(params[:education])
      @education.educ_degree_id = cat_degree.id
      @education.save
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/resume/education')
  end

  def edit
    @e = CandidateEducation.new(:id => params[:id], 
                                :title => params[:title], 
                                :educ_degree_id => params[:educ_degree_id],
                                :university => params[:university],
                                :date_in => params[:date_in],
                                :date_out => params[:date_out])
  end

  def destroy
    CandidateEducation.delete(params[:id])
    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/resume/education')
  end

  def update
    @education = CandidateEducation.new(params[:education])

    if params[:education_educ_degree_id_new] == ""
      CandidateEducation.update(@education.id, 
                                :title => @education.title, 
                                :educ_degree_id => @education.educ_degree_id,
                                :university => @education.university,
                                :date_in => @education.date_in,
                                :date_out => @education.date_out)
    else
      degree = params[:education_educ_degree_id_new]
      cat_degree = EducDegree.new(:name => degree, :description => degree, :approved_flag => false)
      cat_degree.save!
      
      CandidateEducation.update(@education.id, 
                                :title => @education.title, 
                                :educ_degree_id => cat_degree.id,
                                :university => @education.university,
                                :date_in => @education.date_in,
                                :date_out => @education.date_out)
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/resume/education')
  end
end
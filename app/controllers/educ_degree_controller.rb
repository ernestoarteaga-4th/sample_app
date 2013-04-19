class EducDegreeController < ApplicationController
  def index
    @degrees = EducDegree.all
  end

  def new
    
  end

  def create
    @degree = EducDegree.new(params[:degree])

    @cat_degree_rows = EducDegree.where("name = ?", @degree.name)

    if @cat_degree_rows.length > 0
      flash[:notice] = "The Education Degree Already Exists"

    else
      @degree.approved_flag = true
      @degree.approved_by = current_candidate.first_name + " " + 
                            current_candidate.middle_name + " " + 
                            current_candidate.first_last_name + " " + 
                            current_candidate.second_last_name
      @degree.save
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/education_degree')
  end

  def edit
    @d = EducDegree.new(:id => params[:id], 
                        :name => params[:name], 
                        :description => params[:description],
                        :approved_flag => params[:approved_flag])
  end

  def destroy
    @candidateEducations = CandidateEducation.where("educ_degree_id = ?", params[:id])

    if @candidateEducations.length > 0
      flash[:notice] = "This Education Degree is Associated to an Candidate Education, Cannot be Deleted"

    else
      EducDegree.delete(params[:id])
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/education_degree')
  end

  def update
    @degree = EducDegree.new(params[:degree])

    @degree.approved_by = current_candidate.first_name + " " + 
                          current_candidate.middle_name + " " + 
                          current_candidate.first_last_name + " " + 
                          current_candidate.second_last_name
    
    @cat_degree_rows = EducDegree.where("name = ?", @degree.name)

    if @cat_degree_rows.length > 0
      flash[:notice] = "The Education Degree Already Exists"

    else
      EducDegree.update(@degree.id, 
                        :name => @degree.name, 
                        :description => @degree.description,
                        :approved_flag => @degree.approved_flag,
                        :approved_by => @degree.approved_by)
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/education_degree')
  end

  def action
    @degree = params["Selected_ID"]

    if(params[:update_button] != nil)
        @approved_by = current_candidate.first_name + " " + 
                       current_candidate.middle_name + " " + 
                       current_candidate.first_last_name + " " + 
                       current_candidate.second_last_name

      for str in @degree.split(":")
        EducDegree.update(str.split(",")[0], 
                          :approved_flag => str.split(",")[1],
                          :approved_by => @approved_by)
      end
    else

      for str in @degree.split(":")
        if(str.split(",")[1] == 'true')
          EducDegree.delete(str.split(",")[0])
          CandidateEducation.where("educ_degree_id = ?", str.split(",")[0]).update_all(:educ_degree_id => '')
        end
      end
    end

    redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/education_degree')
  end

end
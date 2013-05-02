class ResumeController < ApplicationController
  
  def index
    @candidate = Candidate.find(params[:id])

    if @candidate.resume.nil?
      @candidate.build_resume.save
    end
  end
  
  def summary
    @candidate = Candidate.find(params[:id])
    if request.post?
      if !params[:candidate_prof_summary][:summary].nil? && params[:candidate_prof_summary][:summary].strip != ''
        if @candidate.candidate_prof_summary.update_attributes(params[:candidate_prof_summary])
          flash.now[:success] = "Summary was saved successfully."
          render 'index'
        else
          flash.now[:notice] = "An error occurred while the system save the summary. Please try again."
        end
      else
        flash.now[:notice] = "Write a summary."
      end
    else
      @candidate_prof_summary=@candidate.candidate_prof_summary
    end
  end
  
  def project
    @candidate = Candidate.find(params[:id])
    if @candidate.resume.nil?
      @resume = @candidate.build_resume
      @resume.save
    end
    @project_items = @candidate.resume.projects
  end
   

  
  def education
    if request.post?
      @candidate = Candidate.find(params[:id])
      @total_educations = @candidate.resume.educations
      @education =  @candidate.resume.educations.new(params[:education])
      @error = @education.errors
      if @education.save
        flash[:success] = "Education was saved successfully."      
      end
    else
      @candidate = Candidate.find(params[:id])
      @error = @candidate.errors
      @total_educations = @candidate.resume.educations
    end
  end

  def staff_update
    @started_date = ""
    @recruited_date = ""

    if(params["isRecruited"] == "true")
      if(params["search"]["recruited_date(2i)"].to_i() < 10)
        @recruited_date = params["search"]["recruited_date(1i)"] + "/0" +
                          params["search"]["recruited_date(2i)"]

      else
        @recruited_date = params["search"]["recruited_date(1i)"] + "/" +
                          params["search"]["recruited_date(2i)"]
      end
      
      if(params["search"]["recruited_date(3i)"].to_i() < 10)
        @recruited_date = @recruited_date + "/0" +
                          params["search"]["recruited_date(3i)"]

      else
        @recruited_date = @recruited_date + "/" +
                          params["search"]["recruited_date(3i)"]
      end

      if(params["search"]["start_date(2i)"].to_i() < 10)
        @started_date = params["search"]["start_date(1i)"] + "/0" +
                        params["search"]["start_date(2i)"]

      else
        @started_date = params["search"]["start_date(1i)"] + "/" +
                        params["search"]["start_date(2i)"]
      end
      
      if(params["search"]["start_date(3i)"].to_i() < 10)
        @started_date = @started_date + "/0" +
                        params["search"]["start_date(3i)"]

      else
        @started_date = @started_date + "/" +
                        params["search"]["start_date(3i)"]
      end
      
      Candidate.update(params["search"]["id"], 
                       :currently_in_4Source => params["isRecruited"], 
                       :recruited_at => DateTime.strptime(@recruited_date, "%Y/%m/%d"),
                       :started_at => DateTime.strptime(@started_date, "%Y/%m/%d"),
                       :office_id => params["search"]["office_id"])
    else
      Candidate.update(params["search"]["id"], 
                       :currently_in_4Source => nil, 
                       :recruited_at => nil,
                       :started_at => nil,
                       :office_id => nil)
    end

    redirect_to File.join('/candidates/', params["search"]["id"], '/resume')
  end
end

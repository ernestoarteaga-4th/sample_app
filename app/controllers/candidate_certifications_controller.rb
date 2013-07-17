class CandidateCertificationsController < ApplicationController
  def index
  	logger.debug "*******************index**********************"
    id = params[:candidate_id] unless params.blank?
    if !current_candidate.admin_flag.nil?
      @candidate = Candidate.find(id)
      @error = @candidate.errors
    else
      @candidate = Candidate.find(current_candidate.id)
      @error  = current_candidate.errors
    end
	  #@candidate  = Candidate.find(params[:candidate_id])
   	#@error = @candidate.errors
    @total_certifications = @candidate.candidate_certifications
    #@certification = @candidate.resume.certifications.new
    #@certification  = Certification.new
  end

  def new
  	#WTF???
  end

  def destroy
    CandidateCertification.find(params[:id]).destroy  
    redirect_to request.referer
  end

  def create
  	id = params[:candidate_id] unless params.blank?
    if !current_candidate.admin_flag.nil?
      @candidate = Candidate.find(id)
      @error = @candidate.errors
    else
      @candidate = Candidate.find(current_candidate)
      @error  = current_candidate.errors
    end
    @candidate = Candidate.find(current_candidate)

    puts "json params is:"
    puts  params.to_json 
    certificationExist = false
    certification = Certification.new
    if params[:certification_chBNotInList]
      if(!params[:certification][:name].empty?)
        if Certification.find_by_name(params[:certification][:name])!=nil
          flash[:notice] = "The certification already exist, please search it again in the list."
          certification = nil
          certificationExist = true
        else
          certification.name = params[:certification][:name]
        end

      else
        flash[:notice] = "Please provide a valid Certification name"
        certification = nil
      end
    else
      if params[:certification][:selectName].nil?
        certification = nil
      else
        certification = Certification.find(params[:certification][:selectName])
      end
    end
    @candidate_certification = @candidate.candidate_certifications.build(params[:candidate_certification])
    if  !certification.nil?
      if !certificationExist && CandidateCertification.find_by_certification_id(certification.id).nil? 
        @candidate_certification.certification = certification
      else

        flash[:notice] = "You already have this certification in your list"
        certification = nil
        @candidate_certification = nil
      end
    end

    if(certification!= nil)
      if(@candidate_certification.save)
        flash[:success] = "Certification was saved successfully."
      else
        flash[:notice] = "An error occurred while the system save the certification #{@candidate_language.errors.as_json}"
      end
    else
      
      flash[:notice] = "You already have this certification in your list"
    end
    #redirect_to request.referer
    #id = params[:candidate_id] unless params.blank?
    if !current_candidate.admin_flag.nil?
      #is admin
      redirect_to File.join('/candidates/', id.to_s(), '/candidate_certifications')
    else
      #not an admin
      redirect_to File.join('/candidates/', current_candidate.id.to_s(), '/candidate_certifications')
    end
    
  end
end



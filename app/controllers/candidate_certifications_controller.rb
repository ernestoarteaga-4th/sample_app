class CandidateCertificationsController < ApplicationController
  def index
  	logger.debug "*******************index**********************"
	  @candidate  = Candidate.find(params[:candidate_id])
   	@error = @candidate.errors
    @total_certifications = @candidate.candidate_certifications
    #@certification = @candidate.resume.certifications.new
    #@certification  = Certification.new
  end

  def new
  	logger.debug "*******************new**********************"
    /@certification  = Certification.new
    @error = @certification.errors
    @title = "New Certification"/
  end

  def destroy
	  CandidateCertification.find(params[:id]).destroy
    redirect_to request.referer
  end

  def create
  	logger.debug "*******************create**********************"
    @candidate = current_candidate
    puts "json params is:"
    puts  params.to_json 
    certificationExist = false
    certification = Certification.new
    if params[:certification_chBNotInList]
      if(!params[:certification][:name].empty?)
        if Certification.find_by_name(params[:certification][:name])!=nil
          flash[:notice] = "The certification already exist, pleas search it again in the list."
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
      certification = Certification.find(params[:certification][:selectName])
    end
    @candidate_certification = @candidate.candidate_certifications.build(params[:candidate_certification])
    #logger.debug "********************************************"
    #logger.debug certification.id

    if !certificationExist && CandidateCertification.find_by_certification_id(certification.id).nil? 
      @candidate_certification.certification = certification
    else
      flash[:notice] = "You already have this certification in your list"
      certification = nil
      @candidate_certification = nil
    end

    if(certification!= nil)
      if(@candidate_certification.save)
        flash[:success] = "Certification was saved successfully."
      else
        flash[:notice] = "An error occurred while the system save the languages#{@candidate_language.errors.as_json}"
      end
    end
    redirect_to request.referer
  end
end

/logger.debug "*************************************************"
      logger.debug params[:certification][:name]/
      /logger.debug "------------------------------------------------"
      logger.debug params[:certification][:selectName]/
      /if Certification.find_by_name(params[:certification][:name]).nil?
      @certification = Certification.new
      @certification.name = params[:certification][:name]
      @certification.approved_flag = false
      @certification.save
      @candidate_certification = @candidate.candidate_certifications.build
      @candidate_certification.certification = @certification
      logger.debug @candidate_certification.certification.name
      @candidate_certification.save
    else
      @candidate_certification = @candidate.candidate_certifications.build
      @candidate_certification.certification = Certification.find_by_name(params[:certification][:name])
      @candidate_certification.save
    end/

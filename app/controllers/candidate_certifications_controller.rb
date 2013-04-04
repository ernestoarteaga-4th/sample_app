class CandidateCertificationsController < ApplicationController
  def index
  	logger.debug "*******************index**********************"
	@candidate  = Candidate.find(params[:candidate_id])
   	@error = @candidate.errors
    
    #if @candidate.nil?
      #@candidate.build_resume.save
    #end
    @total_certifications = @candidate.candidate_certifications
    #@certification = @candidate.resume.certifications.new
    #@certification  = Certification.new
  end

  def new
  	logger.debug "*******************new**********************"
    @certification  = Certification.new
    @error = @certification.errors
    @title = "New Certification"
  end

  def destro
	CandidateCertification.find(params[:id]).destroy
    redirect_to request.referer
  end

  def create
  	logger.debug "*******************create**********************"
    @candidate = current_candidate

    certification = Certification.new
    certification.name = params[:certification][:name]
    certification.save
    #certification = Certification.new(params[:certification]).save
    
    logger.debug certification.id
    
    current_candidate.candidate_certifications.build(:certification_id => certification.id).save
    #@candidate.candidate_certifications = CandidateCertification.new
    #@candidate.candidate_certifications.certification_id = certification.id
    #@candidate.candidate_certifications.candidate_id = @candidate.id
	
    #if @candidate.candidate_certifications.save
      #logger.debug "*******************some string**********************"
      #flash.now[:success] = "Certification saved"
    #else
    	#logger.debug "************some string123*********************"
      #flash.now[:notice] = "An error occurred while the system save the summary. Please try again."
    #end

    redirect_to request.referer
  end
end
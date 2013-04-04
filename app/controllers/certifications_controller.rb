class CertificationsController < ApplicationController
	def destroy
	  Certification.find(params[:id]).destroy
      redirect_to request.referer
	end
end

class CertificationsController < ApplicationController
  def index
    @certifications = Certification.all
  end

  def new
    if request.post?
      @certification = Certification.new(params[:certification])
      @cat_certification_rows = Certification.where("name = ?", @certification.name)
      if @cat_certification_rows.length > 0
        flash[:notice] = "The Certification already exists"
      else
        @certification.approved_flag = true
        @certification.approved_by = current_candidate.first_name + " " + 
                              current_candidate.middle_name + " " + 
                              current_candidate.first_last_name + " " + 
                              current_candidate.second_last_name
        @certification.save
        @certifications = Certification.all
        render 'index'
      end
    else
      @certification = Certification.new
    end
  end

  def action
    @certifications = Certification.all

    if(params[:update_button] != nil)
      @certifications.each do |row|
        @certification = params["approved_flag_" + row.id.to_s()]
        row.approved_by = current_candidate.first_name + " " + 
                          current_candidate.middle_name + " " + 
                          current_candidate.first_last_name + " " + 
                          current_candidate.second_last_name

        if(@certification == nil)
          Certification.update(row.id, 
                          :approved_flag => false,
                          :approved_by => row.approved_by)
        else
          Certification.update(row.id, 
                          :approved_flag => true,
                          :approved_by => row.approved_by)
        end
      end
    else
      @certifications.each do |row|
        @certification = params["approved_flag_" + row.id.to_s()]

        if(@certification != nil)
          Certification.delete(row.id)
        end
      end
    end

    render 'index'
  end
end

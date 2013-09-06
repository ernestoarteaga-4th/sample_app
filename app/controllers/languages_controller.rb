class LanguagesController < ApplicationController
  def index
    @languages = Language.all
  end

  def new
    
  end

  def create
  
    @language = Language.new(params[:language])

    @cat_language_rows = Language.where("name = ?", @language.name)
    
    if @language.name.blank? == true
       flash[:notice] = "Invalid language name." 
    end
    
    if @cat_language_rows.length > 0
      flash[:notice] = "The Language Already Exists"

    else
      @language.approved_flag = true
      @language.approved_by = current_candidate.first_name + " " + 
                              current_candidate.middle_name + " " + 
                              current_candidate.first_last_name + " " + 
                              current_candidate.second_last_name
      @language.save
    end

    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/languages')
  end

  def action
    @languages = Language.all

    if(params[:update_button] != nil)
      @languages.each do |row|
        @language = params["approved_flag_" + row.id.to_s()]
        row.approved_by = current_candidate.first_name + " " + 
                          current_candidate.middle_name + " " + 
                          current_candidate.first_last_name + " " + 
                          current_candidate.second_last_name

        if(@language == nil)
          Language.update(row.id, 
                          :approved_flag => false,
                          :approved_by => row.approved_by)
        else
          Language.update(row.id, 
                          :approved_flag => true,
                          :approved_by => row.approved_by)
        end
      end
    else
      @languages.each do |row|
        @language = params["approved_flag_" + row.id.to_s()]

        if(@language != nil)
          Language.delete(row.id)
          FilterLanguage.where("language_id = ?", row.id).update_all(:language_id => '')
        end
      end
    end

    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/languages')
  end
end
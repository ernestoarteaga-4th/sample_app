class ReportController < ApplicationController
  def index

  end

  def search
    @where_tech=""
    @from_tech=""
    if !params[:technologies_id].nil?
      @connector=" "
      params[:technologies_id].each do |t|
        @where_tech = @where_tech + @connector + "ProTag.tags_id=" + t.to_s
        @connector=" OR "
      end
      @where_tech = "AND ("+@where_tech+")"
      @from_tech="LEFT JOIN projects Proj ON Cand.id=Proj.candidate_id 
        LEFT JOIN projects_roles ProRol ON Proj.id=ProRol.projects_id 
        LEFT JOIN projects_tags ProTag ON ProRol.id=ProTag.projects_roles_id "
    end
    
    
    @where_proc=""
    @from_proc=""
    if !params[:recruitingProcess].nil?
      event = params[:search]
      @date_from = Date.new event["date_processing_from(1i)"].to_i, event["date_processing_from(2i)"].to_i, event["date_processing_from(3i)"].to_i
      @date_to = Date.new event["date_processing_to(1i)"].to_i, event["date_processing_to(2i)"].to_i, event["date_processing_to(3i)"].to_i
      @where_proc = " AND (  DATEDIFF('"+@date_from.to_s+"',CandInt.created_at) <= 0 AND DATEDIFF('"+@date_to.to_s+"',CandInt.created_at) >= 0 ) "
      @from_proc=" LEFT JOIN candidates_interviews CandInt ON Cand.id=CandInt.candidate_id "
    end
    
    
    @where_recru=""
    @from_recru=""
    if !params[:isRecruited].nil?
      event = params[:search]
      @date_hired = Date.new event["hire_date(1i)"].to_i, event["hire_date(2i)"].to_i, event["hire_date(3i)"].to_i
      @date_start = Date.new event["start_date(1i)"].to_i, event["start_date(2i)"].to_i, event["start_date(3i)"].to_i
      @where_recru = " AND ( DATE_FORMAT(Cand.recruited_at, '%Y-%m-%d') = '"+@date_hired.to_s+"' OR  DATE_FORMAT(Cand.started_at, '%Y-%m-%d') = '"+@date_start.to_s+"' OR Cand.office_id = '"+params[:search][:office_id]+"'  )"
    end
    
    
    @where_resul=""
    @from_resul=""
    if !params[:search][:points].nil? && params[:search][:points]!='' 
      @where_resul = " AND ( CandInt2.interview_type_id="+params[:interviewTypesOption][:id]+" AND CandInt2.result REGEXP '"+params[:search][:points]+"'  )"
      @from_resul=" LEFT JOIN candidates_interviews CandInt2 ON Cand.id=CandInt2.candidate_id "
    end
    
    
    @where_orig=""
    @from_orig=""
    if !params[:search][:placeOrigin].nil? && params[:search][:placeOrigin]!='' 
      @where_orig = " AND ( Cand.city REGEXP '"+params[:search][:placeOrigin]+"'  )"
    end
    
    
    @sql ="SELECT DISTINCT Cand.* 
      FROM candidates Cand " + @from_tech + @from_proc + @from_recru + @from_resul + @from_orig +
      "WHERE 1=1 "+ @where_tech + @where_proc + @where_recru + @where_resul + @where_orig
    @candidates = Candidate.find_by_sql(@sql)
    
  end
  
end
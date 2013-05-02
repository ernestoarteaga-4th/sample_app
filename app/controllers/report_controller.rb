class ReportController < ApplicationController
  def index
    
  end

  def show
      @candidate = Candidate.all
      respond_to do |format|
        format.html
        format.xls { send_data @candidate.to_xls, content_type: 'application/vnd.ms-excel', filename: 'candidate.xls' }
        
      end
  end

  def search

    @where_tech=""
    if !params[:technologies_id].nil?
      @connector=" "
      params[:technologies_id].each do |t|
        @where_tech = @where_tech + @connector + "ProTag.tags_id=" + t.to_s
        @connector=" OR "
      end
      @where_tech = "AND ("+@where_tech+")"
    end
    
    
    @where_proc=""
    if !params[:recruitingProcess].nil?
      event = params[:search]
      @date_from =event[:date_processing_from]
      @date_to = event[:date_processing_to]
      @where_proc = " AND (  DATEDIFF('"+@date_from.to_s+"',CandInt.created_at) <= 0 AND DATEDIFF('"+@date_to.to_s+"',CandInt.created_at) >= 0 ) "
    end
    
    
    @where_recru=""
    if !params[:isRecruited].nil?
      event = params[:search]
      @date_hired =event[:hire_date]
      @date_start =event[:start_date] 
      @where_recru = " AND ( DATE_FORMAT(Cand.recruited_at, '%Y-%m-%d') = '"+@date_hired.to_s+"' OR  DATE_FORMAT(Cand.started_at, '%Y-%m-%d') = '"+@date_start.to_s+"' OR Cand.office_id = '"+params[:search][:office_id]+"'  )"
    end
    
    
    @where_resul=""
    if !params[:search][:points].nil? && params[:search][:points]!='' 
      @where_resul = " AND ( CandInt.interview_type_id="+params[:interviewTypesOption][:id]+" AND CandInt.result REGEXP '"+params[:search][:points]+"'  )"
    end
    
    
    @where_orig=""
    if !params[:search][:placeOrigin].nil? && params[:search][:placeOrigin]!='' 
      @where_orig = " AND ( Cand.city REGEXP '"+params[:search][:placeOrigin]+"'  )"
    end
    
    @from="LEFT JOIN projects Proj ON Cand.id=Proj.candidate_id 
        LEFT JOIN projects_roles ProRol ON Proj.id=ProRol.project_id 
        LEFT JOIN projects_tags ProTag ON ProRol.id=ProTag.projects_role_id 
        LEFT JOIN candidates_interviews CandInt ON Cand.id=CandInt.candidate_id "
    
    
    @sql ="SELECT DISTINCT Cand.* 
      FROM candidates Cand " + @from +
      "WHERE 1=1 "+ @where_tech + @where_proc + @where_recru + @where_resul + @where_orig
    
    session["excelQry"] = @sql
    
    @candidates = Candidate.find_by_sql(@sql)

    
  end
  
end
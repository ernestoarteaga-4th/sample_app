class ReportController < ApplicationController
  def index
    @technologies = Tag.where("type_tag = 3")
    @interview_types = InterviewsType.all
  end

  def search
    
    
    
    @where_tech=""
    @from_tech=""
    if !params[:technology].nil?
      @connector=" "
      params[:technology].each do |t|
        @where_tech = @where_tech + @connector + "ProTag.tags_id=" + t.to_s
        @connector=" OR "
      end
      @where_tech = "AND ("+@where_tech+")"
      @from_tech="LEFT JOIN projects Proj ON Cand.id=Proj.candidate_id 
        LEFT JOIN projects_roles ProRol ON Proj.id=ProRol.projects_id 
        LEFT JOIN projects_tags ProTag ON ProRol.id=ProTag.projects_roles_id "
    end
    
    
    
    @sql ="SELECT Cand.* 
      FROM candidates Cand " + @from_tech +
      "WHERE 1=1 "+ @where_tech 
    @candidates = Candidate.find_by_sql(@sql); 
    #self.connection.execute(sanitize_sql([@sql]) 
    
    @msg = { "success" => "true", "message" => "hello", "state" => params[:state]}
 
    @technologies = Tag.where("type_tag = 3")
    @interview_types = InterviewsType.all
    render :index
  end
end
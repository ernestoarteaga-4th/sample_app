class ReportController < ApplicationController
  def index
    @candidates = Candidate.paginate(:page => params[:page], 
                                     :conditions => ["admin_flag IS NOT TRUE"],
                                     :per_page => 20)
  end

  def search
    
    @connector=" "
    @tecnologies=""
    params[:technology].each do |t|
      @tecnologies=@tecnologies + @connector + "ProTag.tags_id=" + t.to_s
      @connector=" OR "
    end
    @sql ="SELECT Cand.* 
      FROM candidates Cand 
      INNER JOIN projects Proj ON Cand.id=Proj.candidate_id 
      INNER JOIN projects_roles ProRol ON Proj.id=ProRol.projects_id 
      INNER JOIN projects_tags ProTag ON ProRol.id=ProTag.projects_roles_id 
      WHERE 1=1 AND ("+ @tecnologies + ")"
    @candidates = Candidate.find_by_sql(@sql); 
    #self.connection.execute(sanitize_sql([@sql]) 
    
    @msg = { "success" => "true", "message" => "hello", "state" => params[:state]}
 
    respond_to do |format|
      format.html
      format.json { render json: @msg }
    end
  end
end
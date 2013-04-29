class ExportExcelController < ApplicationController
  def index 
      
     # puts session["excelQry"]
      
    @candidates = Candidate.find_by_sql(session["excelQry"]); 
    #@candidates = Candidate.all
    
    
    csv_string = CSV.generate do |csv|
         csv << ["Name", "Email"]
         @candidates.each do |candi|
           csv << [ candi.first_name, candi.email,]
         end
    end         
  
   send_data csv_string,
   :type => 'text/csv; charset=iso-8859-1; header=present',
   :disposition => "attachment; filename=users.csv"
  end

   
  
end
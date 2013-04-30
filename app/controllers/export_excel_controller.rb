class ExportExcelController < ApplicationController
  def index 
      
     # puts session["excelQry"]
      
    @candidates = Candidate.find_by_sql(session["excelQry"]); 
    #@candidates = Candidate.all
    
    
    
    
    
    csv_string = CSV.generate do |csv|
         csv << ["Name","E-mail", "Phone","Location", "Willing to relocate","Status", 
           "Visa", "Passport", "Rate", "English Score", "Result Tech Interview", 
           "Result Managerial Interview", "Current Salary", "Marital Status"]
         @candidates.each do |candi|
           
           @english =""
           @techSkill =""
           @managerial=""
           
           candi.candidates_interviews.each do |inter|
             
              if inter.interview_type_id == 2
                @english = inter.result
              end
              if inter.interview_type_id == 3
                @techSkill = inter.result
              end
              if inter.interview_type_id == 4
                @managerial = inter.result
              end
           end
           
           csv << [ "#{candi.first_name}  #{candi.first_last_name}", candi.email, candi.cell_phone,
              candi.city, candi.is_willing_to_relocate==true ? "SI":"NO", candi.status_id,
             candi.has_visa==true ? "SI":"NO", candi.has_passport==true ? "SI":"NO", 
             candi.salary_expectancy,@english, @techSkill , @managerial, candi.current_salary, ""]
         end
    end         
  
   send_data csv_string,
   :type => 'text/csv; charset=iso-8859-1; header=present',
   :disposition => "attachment; filename=users.csv"
  end 
  
  
end
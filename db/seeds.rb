require 'csv'

directory = Rails.root.join('db').to_s

#---------------------------------------------------------
# Resume Education
#---------------------------------------------------------
puts "----------------RESUME EDUCATION----------------"
file_name = "Resume Education - CSV"

path_to_file = directory + "/CSV_Files/" + file_name + ".csv"
first = true

if File.exist?(path_to_file)
	CSV.foreach(path_to_file) do |row|
	  if first
	    first = false
	  else
#if all row is blank don't show
		if row[0].blank? and row[1].blank? and row[2].blank? and row[3].blank? and row[4].blank? and row[5].blank?  and row[6].blank?
#puts "blank"
		else
			if Candidate.find_by_id(row[0]).nil? or EducDegree.find_by_id(row[3]).nil?
				puts "Candidate id: " + row[0].to_s + " or Education Degree id: " + row[3].to_s + " , No exist in database"
			else
				@candidate = Candidate.find_by_id(row[0])
				cat_degree = EducDegree.find_by_id(row[3])

				msg1 = "Candidate: " + @candidate.id.to_s + " - " + @candidate.name + " -- Education Degree: " + cat_degree.id.to_s + " - " + cat_degree.name

				@education = CandidateEducation.new
				@education.candidate_id = @candidate.id
				@education.educ_degree_id = cat_degree.id
				if !row[2].nil?
					@education.title = row[2]	
				end
				if !row[1].nil?
					@education.degree = row[1]	
				end
				if !row[6].nil?
					@education.university = row[6]	
				end
				
				if !row[4].blank?
					@education.date_in = row[4].to_date
				end
				if !row[5].blank?
					@education.date_out = row[5].to_date
				end				                 				

			    if(cat_degree!= nil)
			      if(@education.save)
			        puts msg1 + " - was saved successfully."
			      else
			        puts msg1 +  " - An error occurred while the system save"
			      end
			    end
			end
		end
	  end
	end
else
	puts "File does not exist: " + path_to_file
end

=begin
#---------------------------------------------------------
# Resume Trainings
#---------------------------------------------------------
puts "----------------RESUME TRAININGS----------------"
file_name = "Resume Trainings - CSV"

path_to_file = directory + "/CSV_Files/" + file_name + ".csv"
first = true

if File.exist?(path_to_file)
	CSV.foreach(path_to_file) do |row|
	  if first
	    first = false
	  else
#if all row is blank don't show
		if row[0].blank? and row[1].blank? and row[2].blank? and row[3].blank? and row[4].blank?
#puts "blank"
		else
			if Candidate.find_by_id(row[0]).nil?
				puts "Candidate id: " + row[0].to_s + " , No exist in database"
			else
				@candidate = Candidate.find_by_id(row[0])

				msg1 = "Candidate: " + @candidate.id.to_s + " - " + @candidate.name + " -- Project Name:  " + row[2]

				@project = Project.new
				@project.candidate_id = @candidate.id
				@project.name = row[2]
				@project.summary = row[3]
				@project.company_name = row[4]

		      if @project.save
		        puts msg1 + " - was saved successfully."
		      else
			    puts msg1 +  " - An error occurred while the system save"
		      end
			end
		end
	  end
	end
else
	puts "File does not exist: " + path_to_file
end
=end

#---------------------------------------------------------
# Resume Idioms
#---------------------------------------------------------
puts "----------------RESUME IDIOMS----------------"
file_name = "Resume Idioms - CSV"

path_to_file = directory + "/CSV_Files/" + file_name + ".csv"
first = true

if File.exist?(path_to_file)
	CSV.foreach(path_to_file) do |row|
	  if first
	    first = false
	  else
#if all row is blank don't show
		if row[0].blank? and row[1].blank? and row[2].blank? and row[3].blank?
#puts "blank"
		else
			if Candidate.find_by_id(row[0]).nil? or Language.find_by_id(row[1]).nil?
				puts "Candidate id: " + row[0].to_s + " or Language id: " + row[1].to_s + " , No exist in database"
			else
				@candidate = Candidate.find_by_id(row[0])
				language = Language.find_by_id(row[1])

				msg1 = "Candidate: " + @candidate.id.to_s + " - " + @candidate.name + " -- language: " + language.id.to_s + " - " + language.name

				@candidate_language = CandidateLanguage.new

				@candidate_language.candidate_id = @candidate.id
				@candidate_language.level_id = row[3]
				@candidate_language.language = language

			    if (language != nil )
			      if @candidate_language.save
			        puts msg1 + " - was saved successfully."
			      else
			        puts msg1 +  " - An error occurred while the system save"
			      end
			    end
			end
		end
	  end
	end
else
	puts "File does not exist: " + path_to_file
end

#---------------------------------------------------------
# Resume Certification
#---------------------------------------------------------
puts "----------------RESUME CERTIFICATION----------------"

file_name = "Resume Certification - CSV"

path_to_file = directory + "/CSV_Files/" + file_name + ".csv"
first = true

if File.exist?(path_to_file)
	CSV.foreach(path_to_file) do |row|
	  if first
	    first = false
	  else
#if all row is blank don't show
		if row[0].blank? and row[1].blank? and row[2].blank?
#puts "blank"
		else
			if Candidate.find_by_id(row[0]).nil? or Certification.find_by_id(row[1]).nil?
				puts "Candidate id: " + row[0].to_s + " or Certification id: " + row[1].to_s + " , No exist in database"
			else
				@candidate = Candidate.find_by_id(row[0])
				certification = Certification.find_by_id(row[1])

				msg1 = "Candidate: " + @candidate.id.to_s + " - " + @candidate.name + " -- Certification: " + certification.id.to_s + " - " + certification.name

				@candidate_certification = CandidateCertification.new
				@candidate_certification.candidate_id = @candidate.id
				@candidate_certification.certification_id = certification.id
				@candidate_certification.candidate = @candidate
				@candidate_certification.certification = certification

			    if(certification!= nil)
			      if(@candidate_certification.save)
			        puts msg1 + " - was saved successfully."
			      else
			        puts msg1 +  " - An error occurred while the system save"
			      end
			    end
			end
		end
	  end
	end
else
	puts "File does not exist: " + path_to_file
end	

#---------------------------------------------------------
# Projects
#---------------------------------------------------------
puts "----------------PROJECTS & ROLES----------------"
file_name  = "Projects - CSV"
file_name2 = "Projects roles - CSV"

path_to_file  = directory + "/CSV_Files/" + file_name  + ".csv"
path_to_file2 = directory + "/CSV_Files/" + file_name2 + ".csv"

first = true

if File.exist?(path_to_file) and File.exist?(path_to_file2)   
#PROJECTS		
	CSV.foreach(path_to_file) do |row|
	  if first
	    first = false
	  else
#if all row is blank don't show
		if row[0].blank? and row[1].blank? and row[2].blank? and row[3].blank? and row[4].blank?
#puts "blank"
		else
			if Candidate.find_by_id(row[0]).nil?
				puts "Candidate id: " + row[0].to_s + " , No exist in database"
			else
				@candidate = Candidate.find_by_id(row[0])

				msg1 = "Candidate: " + @candidate.id.to_s + " - " + @candidate.name + " -- Project Name:  " + row[2]

				@project = Project.new
				@project.candidate_id = @candidate.id
				@project.name = row[2]
				@project.summary = row[3]
				@project.company_name = row[4]				

		      if @project.save
		        puts msg1 + " - was saved successfully."

#ROLES
				#Looking if the candidate & project have roles
				CSV.foreach(path_to_file2) do |row2|
					if row2[0].blank? and row2[1].blank? and row2[2].blank? and row2[3].blank? and row2[4].blank? and row2[5].blank?
#Empty Row						
					else
						if row2[0] == row[0] and row2[2] == row[2]
							msg2 = "Candidate: " + @candidate.id.to_s + " - " + @candidate.name + " -- Project Name:  " + row[2] + " -- Role id: " + row2[3].to_s

							@projrole  = Projrole.new
							@projrole.projects_id = @project.id
							@projrole.roles_id = row2[3]
							if !row2[4].blank?
								@projrole.date_in = row2[4].to_date	
							end
							if !row2[5].blank?
								@projrole.date_out = row2[5].to_date
							end							

							if @projrole.save
								puts msg2 + " - was saved successfully."
							else
								puts msg2 +  " - An error occurred while the system save"
							end					
						end
					end
				end
		      else
			    puts msg1 +  " - An error occurred while the system save"
		      end
			end
		end
	  end
	end
else
	puts "File does not exist: " + path_to_file + " OR " + path_to_file2
end
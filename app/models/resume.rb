class Resume < ActiveRecord::Base
 
  belongs_to      :candidate
  
  has_many        :experiences, :dependent => :destroy
  has_many        :resume_details, :dependent => :destroy  
  has_many        :educations, :dependent => :destroy  
  has_many        :resume_trainings, :dependent => :destroy
  has_many        :resume_certifications, :dependent => :destroy
  has_many        :certifications, :through => :resume_trainings
  has_many        :resume_languages, :dependent => :destroy
  has_many        :language_levels, :through => :resume_languages
  has_many        :resume_educations, :dependent => :destroy
  has_many        :education_degrees, :through => :resume_educations
  has_many        :projects, :dependent => :destroy
  has_many        :project_roles, :through => :projects

  validates :candidate, :presence => true
  
end

class Candidate < ActiveRecord::Base
  self.per_page = 10

  attr_accessor   :password

  attr_accessible :address, 
  :address1, 
  :avatar_file_name, 
  :birthdate, 
  :cell_phone, 
  :change_password_flag, 
  :city,
  :comments, 
  :company, 
  :country,
  :created_at, 
  :current_salary, 
  :currently_employed, 
  :marital_status,
  :degree, 
  :email, 
  :first_last_name, 
  :first_name, 
  :gender,
  :graduation_year, 
  :has_passport, 
  :has_visa, 
  :home_phone, 
  :is_willing_to_relocate, 
  :is_willing_to_travel, 
  :middle_name, 
  #:mobile, 
  :name, 
  :neighborhood, 
  :office_phone, 
  #:office_telephone, 
  :passport_expiration_year, 
  :position, 
  :salary_expectancy, 
  :second_last_name, 
  :status_id, 
  :technology_id, 
  #:telephone, 
  :university, 
  :updated_at, 
  :updated_by, 
  :visa_expiration_year, 
  :zip_code,
  :password,
  :password_confirmation,
  :change_password_flag,
  :admin_flag,
  :currently_in_4Source,
  :recruited_at,
  :started_at,
  :office_id,
  :email_alternate_1,
  :email_alternate_2,
  :email_alternate_3

  has_many        :microposts,         :dependent => :destroy   
  has_many        :followings,         :foreign_key => "follower_id",
                                       :dependent => :destroy                            
  has_many        :reverse_followings, :foreign_key => "followed_id",
                                       :class_name => "Following",
                                       :dependent => :destroy
  has_many        :followers,          :through => :reverse_followings, 
                                       :source => :follower
  has_many        :following,          :through => :followings, 
                                       :source => :followed
  has_many        :projects,           :foreign_key => "candidate_id",
                                       :dependent => :destroy 
  has_one         :resume,             :dependent => :destroy 

  has_many        :candidate_certifications,      :dependent => :destroy
  has_many        :candidate_trainings,      :dependent => :destroy

  has_many        :candidate_languages, :dependent => :destroy
  has_many        :candidate_education,      :dependent => :destroy

  has_many        :candidate_prof_summary,      :dependent => :destroy
  has_many        :candidates_interviews,   :foreign_key => "candidate_id",
                                            :dependent => :destroy

  has_many        :candidates_profiles,      :dependent => :destroy                                            

  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "40x40#" },
                             :default_url => "/images/4thsource_avatar.jpg"
  
  
  acts_as_ferret :fields => ['name', 'email']

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  phone_regex = /\A[0-9]{10}\Z/

  #validates :name,            :presence => true,
  #                            :length   => { :maximum => 50 }
  validates :first_name,       :presence => true,
                              :length   => { :maximum => 50 }

  validates :first_last_name,       :presence => true,
                              :length   => { :maximum => 50 }
  #validates :second_last_name,:presence => true,
  #                            :length   => { :maximum => 50 }
  validates :email,           :presence => true,
                              :format   => { :with => email_regex },
                              :uniqueness => { :case_sensitive => false }
  validates :password,        :confirmation => true
  #validates :address,         :presence => true
  #validates :city,            :presence => true
  
  #validates :gender,          :inclusion => { :in => %w(M F),
  #                            :message => "is invalid" }
      
  validates :zip_code,        :length => { :minimum => 5 }, :allow_nil => true,
                              :numericality => { :only_integer => true }
  validates :home_phone,      :format => { :with => phone_regex },
                              :allow_blank => true,
                              :allow_nil => true,
                              :numericality => { :only_integer => true },
                              :length => { :minimum => 10 }
  validates :cell_phone,      :format => { :with => phone_regex },
                              :allow_blank => true,
                              :allow_nil => true,
                              :numericality => { :only_integer => true },
                              :length => { :minimum => 10 }
  validates :office_phone,    :format => { :with => phone_regex },
                              :allow_blank => true,
                              :allow_nil => true,
                              :numericality => { :only_integer => true },
                              :length => { :minimum => 10 }

  before_save :encrypt_password


def validate

    if country == '0'
      errors.add_to_base("Country is invalid")
    end
  end
  
  def feed
     Micropost.from_candidates_followed_by(self)
  end

  def is_follow?(follow_user)
    follow = Following.where("follower_id = ? AND followed_user = ?", id, follow_user)
     
    if follow.empty?
     false
    else
      true
    end 
 end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    if user.nil?
      nil
    elsif user.has_password?(submitted_password)
      user
    end
  end

  def self.authenticate_with_salt(id, cookie_salt) 
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  def salary_expectancy=(num)
    self[:salary_expectancy] = num.to_s.scan(/\b-?[\d.]+/).join.to_f
  end

  private
    def encrypt_password
      self.salt = make_salt if new_record?
      if password != change_password_flag && password!=""
        self.encrypted_password = encrypt(password)
      end
    end

    def encrypt(string) 
      secure_hash("#{salt}--#{string}")
    end

    def make_salt 
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string) 
      Digest::SHA2.hexdigest(string)
    end
end

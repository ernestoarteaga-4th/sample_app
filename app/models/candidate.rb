class Candidate < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :address,
  :address1,
  :avatar,
  :birthdate,
  :cell_phone,
  :certifcations,
  :password,
  :password_confirmation,
  :change_password_flag,
  :city,
  :comments,
  :company,
  :country,
  :created_at,
  :current_salary,
  :currently_employed,
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
  :resume_id,
  :salary_expectancy,
  :second_last_name,
  :status_id,
  :techonlogy_id,
  #:telephone,
  :university,
  :updated_at,
  :updated_by,
  :visa_expiration_year,
  :zip_code

  #validates :name, :presence => true

  validates :email, :presence => true

  validates :password, :confirmation => true

  has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "40x40#" },
                             :default_url => "/images/4thsource_avatar.jpg"

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    candidate = find_by_email(email)
    if candidate.nil?
      nil
    elsif candidate.has_password?(submitted_password)
      candidate
    end
  end

  def self.authenticate_with_salt(id, cookie_salt)
    candidate = find_by_id(id)
    (candidate && candidate.salt == cookie_salt) ? candidate : nil
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

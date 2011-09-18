require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password
	validates :email, :uniqueness => true, 
			  :length => { :within => 5..50 },
			  :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
	validates :password, :confirmation => true,
			     :length => { :within => 4..20 },
			     :presence => true,
			     :if => :password_required?
	
	has_many :places, :order => 'published_at DESC, title ASC',
			  :dependent => :nullify
  
  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile, :allow_destroy => true
	before_save :encrypt_new_password

	def self.authenticate(email, password)
		user = find_by_email(email)
		return user if user && user.authenticated?(password)	
	end
	
	def authenticated?(password)
		self.hashed_password == encrypt(password)	
	end

	protected
		def encrypt_new_password
			return if password.blank?
			self.hashed_password = encrypt(password)
		end

		def password_required?
			hashed_password.blank? || password.present?
		end

		def encrypt(string)
			Digest::SHA1.hexdigest(string)
		end

end

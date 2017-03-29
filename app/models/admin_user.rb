class AdminUser < ApplicationRecord
	
	#find legacy database: self.table_name = "admin_users"

	has_secure_password 
	has_and_belongs_to_many :pages
	has_many :section_edits
	#reach through the section_edits to join sections
	has_many :sections, :through => :section_edits

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/i
	FORBIDDEN_USERNAMES = ['turtle', 'butt', 'ghost']

	validates :first_name, :presence => true, :length => { :maximum => 25 }

	validates :last_name, :presence => true, :length => { :maximum => 50 }

	validates :username, :length => { :within => 8..25 }, :uniqueness => true

	validates :email, :presence => true, :length => { :maximum => 100 }, :format => EMAIL_REGEX, :confirmation => true 

	validate :username_is_allowed

	validate :no_new_users_on_monday, :on => :create 

	scope :sorted, lambda { order('last_name ASC', 'first_name ASC')}

	def name
		"#{first_name} #{last_name}"
	end

	private

	def username_is_allowed
		if FORBIDDEN_USERNAMES.include?(username)
			errors.add(:username, "has been restricted!")
		end
	end

	def no_new_users_on_monday
		if Time.now.wday == 1
			errors.add(:base, "No new users on Mondays.")
		end
	end
	
end

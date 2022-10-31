class User < ApplicationRecord
	has_many :orders, dependent: :destroy

	has_secure_password
	before_validation :normalize_phone
	validates :email, presence: true, uniqueness: {message: 'This email is already in use'}, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
	validates :phone, presence: {message: 'Phone number is required'}, uniqueness: {message: 'This phone number is already in use'}, phone: {message: 'Invalid phone number'}
	# before_save :normalize_phone

	attr_accessor :vcode

	def tab; "%0.2f" % orders.sum(:charge_amount) end
	def format_max_tab
		if max_outstanding_tab then "$%0.2f" % max_outstanding_tab else '' end
	end
	def format_tab
		amount = "%0.2f" % orders.sum(:charge_amount).to_f.abs.to_s
		if orders.sum(:charge_amount) > 0
			'$' << amount
		else
			'($' << amount << ')'
		end
	end
	def format_phone
		parsed_phone = Phonelib.parse(phone)
		return phone if parsed_phone.invalid?
	    
		formatted =
			if parsed_phone.country_code == "1" # NANP
				parsed_phone.full_national # (415) 555-2671;123
			else
				parsed_phone.full_international # +44 20 7183 8750
			end
		formatted.gsub!(";", " x") # (415) 555-2671 x123
		formatted
	end	    

	def verify_user
	end
p
	def normalize_phone
		self.phone = Phonelib.parse(phone).full_e164.presence
	end
end
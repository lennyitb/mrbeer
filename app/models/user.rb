class User < ApplicationRecord
	has_secure_password
	has_many :orders, dependent: :destroy
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
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
end
require "#{Rails.root}/lib/persistant.rb"

class ApplicationController < ActionController::Base
	include Persistant

	before_action :set_current_user

	PersistantObj.persistantpath = 'persistant'
	$beerprice = PersistantObj.new name: 'beerprice', input_filter: /^\d{1,4}(\.\d{1,2})?$/, output_format: "%0.2f"
	def set_current_user
		Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
	end
	def require_user_logged_in!
		redirect_to sign_in_path, alert: 'You must be signed in' if Current.user.nil?
	end
	def require_admin!
		if Current.user.nil?
			redirect_to sign_in_path, alert: 'You must be signed in'
		else
			redirect_to sign_in_path, alert: 'You must be signed in as admin' unless Current.user.admin
		end
	end
end
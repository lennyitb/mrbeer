class SessionsController < ApplicationController
	def new; end
	def create
		user = User.find_by(email: params[:email])
		if user.present? && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to root_path, notice: 'Logged in successfully'
		else
			flash.now[:alert] = 'Invalid email or password'
			render :new
		end
	end

	def phone_sign_in; end
	def phone_sign_in_submit
		phone = Phonelib.parse(params[:phone]).full_e164.presence
		user = User.find_by(phone: phone)
		if user.present?
			session[:pending_id] = user.id
			session[:phone] = user.phone
			redirect_to phone_sign_in_verify_path
		else
			redirect_to phone_sign_in_path, notice: 'Phone number does not belong to an account'
		end
	end

	def phone_sign_in_verify;
		session[:user_vcode] = ("%05d" % rand(10000)).to_s
		client = Twilio::REST::Client.new
		message = client.messages.create(
			messaging_service_sid: 'MG8e9eabfe2f53c6d812aa3d404f52d061',
			to: '+17749943082',
			# to: session[:phone],
			body: 'your Mr. Beer verification code is: ' << session[:user_vcode]
		)
	end
	def phone_sign_in_verify_submit
		finput = params[:verification_code]
		if finput == session[:user_vcode]
			session[:user_id] = session[:pending_id]
			# Current.user = User.find_by(id: session[:user_id])
			redirect_to root_path, notice: 'Logged in successfully'
			puts "\nUSER ID: " << session[:user_id].to_s << "\n"
		else
			redirect_to phone_sign_in_verify_path, notice: 'Invalid input, sending a new code'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path, notice: 'Logged Out'
	end
end
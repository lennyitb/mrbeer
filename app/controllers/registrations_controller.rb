class RegistrationsController < ApplicationController
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			# redirect_to root_path, notice: 'Successfully created account'
			# set_current_user
			redirect_to verify_phone_path, notice: 'Successfully created account'
		else
			render :new
		end
	end
	def verify_phone;
		# set_current_user
		require_user_logged_in!
		user = User.find session[:user_id]
		if user.verified == true then redirect_to index_path, notice: 'Your phone is already verified!' end
		session[:user_vcode] = ("%05d" % rand(100000)).to_s
		client = Twilio::REST::Client.new
		message = client.messages.create(
			messaging_service_sid: 'MG8e9eabfe2f53c6d812aa3d404f52d061',
			to: user.phone,
			body: 'your Mr. Beer verification code is: ' << session[:user_vcode]
		)
	end
	def post_verify
		finput = params[:verification_code]
		# if finput =~ /^\d{5}$/
		if finput == session[:user_vcode]
			user = User.find session[:user_id]
			user.verified = true
			redirect_to root_path, notice: 'Successfully created account'
		else
			redirect_to verify_phone_path, notice: 'Invalid input, sending a new code'
		end
	end

	private
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation, :phone)
		end
end
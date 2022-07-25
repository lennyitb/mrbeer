class TwilioController < ApplicationController
	skip_before_action :verify_authenticity_token

	def verify
		code = rand(100000).to_s
		client = Twilio::REST::Client.new
		message = client.messages.create (
			from: '+17377274762',
			to: '+17749943082',
			body: 'your verification code is: ' << code
		)
		return code
	end
	# def sms
	# 	body = helpers.parse_sms params
	# 	response = Twilio::TwiML::MessagingResponse.new do |r|
	# 		r.message body: body
	# 	end
	# 	render xml: response.to_s
	# end
end
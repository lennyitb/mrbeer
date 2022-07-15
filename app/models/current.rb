class Current < ActiveSupport::CurrentAttributes
	attribute :user
	def price
		urate = (user[:price_percent].to_f/100) * $beerprice.value.to_f
		umin = user[:min_price]
		umax = user[:max_price]
		bp = if urate < umin
			umin
		elsif urate > umax
			umax
		else
			urate
		end
		format "%0.2f", bp
	end
end
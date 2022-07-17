module YourBeerPrice
	def getbeerprice currentuser
		include Persistant

		urate = (currentuser.price_percent.to_f/100) * $beerprice.value.to_f
		umin = currentuser.min_price
		umax = currentuser.max_price
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
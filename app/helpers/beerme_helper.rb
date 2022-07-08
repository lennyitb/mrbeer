module BeermeHelper
	def getbeerprice
		# $beerprice = File.open("beerprice.txt") if $beerprice == nil
		urate = (Current.user.price_percent.to_f/100) * $beerprice.read.to_f
		umin = Current.user.min_price
		umax = Current.user.max_price
		# urate.to_s << " " << umin.to_s << " " << umax.to_s
		if urate < umin
			umin
		elsif urate > umax
			umax
		else
			urate
		end
	end
end
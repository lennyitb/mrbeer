module Persistant

	module TypeEnforcer

		def hashtypecheck hash, keytypehash
			return true if hash.map { |key, value| [key, value.class] }.to_h == keytypehash
			keytypehash.map do |key, value|
				if hash[key] == nil then
					fail ArgumentError, "Error in call to #{caller[3][/`.*$/]}.\nRequired argument #{key} of type #{value.to_s} is missing", caller[2..]
				elsif hash[key].class != value then
					fail ArgumentError, "Error in call to #{caller[3][/`.*$/]}.\nGiven argument of type #{hash[key].class.to_s} when #{value} was expected", caller[2..]
				end
			end
		end

		def insertdefaults hash, defaults
			missingargs = defaults.map do |key, value|
				if hash[key] == nil then [key, value] end				# Create a list of all missing arguments
			end.reject { |x| x == nil }							# Remove nil values
			if missingargs.length > 0; missingargs.to_h.merge hash; else; hash; end		# Turn the list to a hash and merge with argument hash
		end
	end

	class PersistantObj

		include TypeEnforcer

		class << self	# there is no attr_accessor for class variables
			@@instcount = 0
			@@persistantpath = 'persistant'
			@@persistantobjnames = []
			def persistantpath; @@persistantpath; end
			def persistantpath= newpath; @@persistantpath = newpath; end
		end
		def initialize ihash 
			dhash = insertdefaults ihash, {name: @@instcount.to_s, input_filter: /.*/, output_format: "%s"}
			hashtypecheck dhash, {name: String, input_filter: Regexp, output_format: String}
			@name = dhash[:name]
			@@persistantobjnames.each do |n|
				if @name == n then fail 'Attempted to create two PersistantObj of same name'; end
			end; @@persistantobjnames += [ @name ]
			@input_filter = dhash[:input_filter]
			@output_format = dhash[:output_format]
			@pathname = @@persistantpath << '/' << @name << '.txt'
			@instnum = @@instcount
			@@instcount += 1
			if File.exist? @pathname then
				set File.read @pathname
			elsif dhash[:value] != nil then
				set dhash[:value]
			end
		end

		attr_reader :instnum, :pathname, :name, :value

		def set input
			# return false unless input.class == @value_type or @value_type == nil
			if input =~ @input_filter
				@value = format @output_format, input
				write
				true
			else; false; end
		end
		def value= input; set input; end
		def get; @value; end

	private

		def write; File.write(@pathname, @value, mode: 'w'); end
	end
end
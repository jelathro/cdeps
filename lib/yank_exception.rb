
module Yank
	class YankException < Exception
		attr_reader :exit_code

		def initialize(message)
			super(message)

			@exit_code = 1
		end
	end
end

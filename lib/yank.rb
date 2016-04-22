require_relative 'vcs/git'
require_relative 'yank_exception'
require_relative 'logging'

module Yank
	class Yank
		include ::Yank::Logging

		def install(options, target)
			for yank in options["yanks"]
				logger.debug("installing yank: #{yank}")
				vcs = get_vcs(yank)

				logger.debug("install yank with vcs: #{vcs}")
				vcs.install(target)
			end
		end

	private
		def get_vcs(yank)
			vcs = nil

			case yank["vcs"]
			when 'git'
				vcs = Git.new(yank["alias"], yank["repo"], yank["version"])
			end

			if vcs.nil?
				raise YankException.new("illegal vcs.")
			end

			return vcs
		end
	end
end

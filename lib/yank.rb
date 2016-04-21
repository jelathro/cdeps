require_relative 'vcs/git'
require_relative 'yank_exception'

module Yank
	def self.process(options, target)
		for yank in options["yanks"]
			vcs = get_vcs(yank)
			vcs.install(target)
		end
	end

	def self.get_vcs(yank)
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

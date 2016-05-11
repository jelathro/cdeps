require 'kwalify'
require_relative 'yank_exception'
require_relative 'logging'

module Yank
	class Yank
		include ::Yank::Logging

		def install(options, target)
			for yank in options["yanks"]
				logger.debug("verifying yank: #{yank}")
				vcs = get_vcs(yank)

				if ::Yank.yank_exists?(yank["alias"].nil?? vcs.name: yank["alias"], target)
					logger.debug("yank already installed, skipping")
					next
				end

				logger.debug("installing yank with vcs: #{vcs}")
				vcs.install(target)

				if yank["recurse"]
					yank_file = ::Yank.get_yanks_file(target, yank["alias"].nil?? vcs.name: yank["alias"])

					return if yank_file.nil?

					logger.debug("recursing into #{yank_file}")
					return install(::Yank::parse_yanks(yank_file), target)
				end
			end
		end

	private
		def get_vcs(yank)
			vcs = nil

			case yank["vcs"]
			when 'git'
				require_relative 'vcs/git'
				vcs = ::Yank::Git.new(yank["alias"], yank["repo"], yank["version"])
			when 'nexus'
				require_relative 'vcs/nexus'
				vcs = ::Yank::Nexus.new(yank["alias"], yank["repo"], yank["version"])
			end

			if vcs.nil?
				raise ::Yank::YankException.new("illegal vcs.")
			end

			return vcs
		end
	end

	def self.yank_exists?(name, target)
		return File.exists?(File.join(target, name))
	end

	def self.get_yanks_file(target, name)
		yanks_file = File.join(target, name, ".yanks")

		if yanks_file.nil? || !File.exists?(yanks_file)
			return nil
		else
			return yanks_file
		end
	end

	def self.parse_yanks(yank_file)
		schema    = Kwalify::Yaml.load_file("#{File.join(File.dirname(__FILE__), 'yank.kwalify')}")
		validator = Kwalify::Validator.new(schema)
		document  = Kwalify::Yaml.load_file(yank_file)
		errors    = validator.validate(document)

		if !errors.nil? && !errors.empty?
			raise ::Yank::YankException.new("unable to validate '#{yank_file}' file: #{errors.join('\n')}.")
		end

		return document
	end
end

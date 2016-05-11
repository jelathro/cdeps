require 'nexus_client'
require_relative '../logging'

module Yank
	class Nexus
		attr_reader :name

		include ::Yank::Logging

		def initialize(artifact_name, repo, version)
			@name = artifact_name
			@repo = repo
			@version = version

			logger.debug("nexus repo: #{@repo}")
			logger.debug("nexus artifact name: #{@name}")
			logger.debug("nexus artifact version: #{@version}")
		end

		def install(dir)
			logger.debug("Preparing nexus client download from #{@repo}...")
			client = Nexus::Client.new(@repo, nil, false, false, logger)

			if @version["type"] == "gav"
				client.download_gav("#{dir}/#{@name}", "#{@version["value"]}")
			else
				raise ::Yank::YankException.new("gav must be the version type with nexus specified.")
			end
		end
	end
end

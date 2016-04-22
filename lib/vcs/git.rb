require 'open3'
require_relative '../logging'

module Yank
	class Git
		include ::Yank::Logging

		def initialize(repo_name, repo, version)
			git = `which git`
			if git.nil? or git.empty?
				raise YankException.new("git must be installed and on the PATH.")
			end

			@repo = repo
			@repo_name = repo_name || @repo.split(".git")[0].split("/").last
			@version = version

			logger.debug("git repo: #{@repo}")
			logger.debug("git repo name: #{@repo_name}")
			logger.debug("git repo version: #{@version}")
		end

		def install(dir)
			logger.debug("Cloning into #{@repo}...")
			logger.debug(Open3.capture3("git clone --recursive #{@repo} #{dir}/#{@repo_name}"))

			case @version["type"]
			when "branch", "tag", "commit"
				logger.debug("Checking out #{@version["value"]}...")
				logger.debug(Open3.capture3("cd #{dir}/#{@repo_name} && git checkout #{@version["value"]}"))
			end
		end
	end
end

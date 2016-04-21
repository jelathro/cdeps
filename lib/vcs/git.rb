
module Yank
	class Git
		def initialize(repo_name, repo, version)
			git = `which git`
			if git.nil? or git.empty?
				raise YankException.new("git must be installed and on the PATH.")
			end

			@repo = repo
			@repo_name = repo_name || @repo.split(".git")[0].split("/").last
			@version = version
		end

		def install(dir)
			puts "Cloning into #{@repo}..."
			`git clone --recursive #{@repo} #{dir}/#{@repo_name}`

			case @version["type"]
			when "branch", "tag", "commit"
				puts "Checking out #{@version["value"]}..."
				`cd #{dir}/#{@repo_name} && git checkout #{@version["value"]}`
			end
		end
	end
end

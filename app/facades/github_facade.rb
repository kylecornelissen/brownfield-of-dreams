class GithubFacade
  attr_reader :render
  def initialize(user)
    if user.token != nil
      @render = "partials/github_repos"
    else
      @render = "partials/github_auth_prompt"
    end
  end

  def repos(limit = nil)
    if limit
      repos = GithubService.new.repo_info.take(limit)
    else
      repos = GithubService.new.repo_info
    end
    repos.map do |repo|
      GithubRepo.new(repo)            
    end
  end
end

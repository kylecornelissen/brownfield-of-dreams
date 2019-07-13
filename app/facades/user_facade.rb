class UserFacade
  attr_reader :render, :render_follows
  def initialize(user)
    @user = user
    if user.token != nil
      @render = "partials/github_repos"
      @render_follows = "partials/github_follows"
    else
      @render = "partials/github_auth_prompt"
    end
  end

  def tutorials
    @user.bookmarks
  end

  def repos(limit = nil)
    if limit
      repos = GithubService.new(@user).repo_info.take(limit)
    else
      repos = GithubService.new(@user).repo_info
    end
    repos.map do |repo|
      GithubRepo.new(repo)
    end
  end

  def follows(followers_or_following)
    follows = GithubService.new(@user).follow_info(followers_or_following)
    follows.map do |follow|
      GithubHandle.new(follow)
    end
  end
end

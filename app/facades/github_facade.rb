class GithubFacade
  attr_reader :render, :render_followers
  def initialize(user)
    @user = user
    if user.token != nil
      @render = "partials/github_repos"
      @render_followers = "partials/github_followers"
    else
      @render = "partials/github_auth_prompt"
    end
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

  def followers
    followers = GithubService.new(@user).follower_info
    followers.map do |follower|
      GithubFollower.new(follower)
    end
  end
end

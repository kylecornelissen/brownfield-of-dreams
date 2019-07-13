class UserFacade
  attr_reader :render, :render_followers, :render_following
  def initialize(user)
    @user = user
    if user.token != nil
      @render = "partials/github_repos"
      @render_followers = "partials/github_followers"
      @render_following = "partials/github_following"
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

  def followers
    followers = GithubService.new(@user).follower_info
    followers.map do |follower|
      GithubHandle.new(follower)
    end
  end

  def following
    following = GithubService.new(@user).following_info
    following.map do |following|
      GithubHandle.new(following)
    end
  end
end

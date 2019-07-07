class GithubFollowing
  attr_reader :path, :login_name
  def initialize(data = {})
    @path = data[:html_url]
    @login_name = data[:login]
  end
end

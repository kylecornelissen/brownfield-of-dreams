class GithubHandle
  attr_reader :path, :login_name, :uid
  def initialize(data = {})
    @path = data[:html_url]
    @login_name = data[:login]
    @uid = data[:id]
  end
end

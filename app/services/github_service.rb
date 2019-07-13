# frozen_string_literal: true

class GithubService
  def initialize(user)
    @user = user
  end

  def repo_info
    JSON.parse(conn.get('/user/repos').body, symbolize_names: true)
  end

  def follow_info(followers_or_following)
    JSON.parse(conn.get("/user/#{followers_or_following}").body, symbolize_names: true)
  end

  def get_email(handle)
    JSON.parse(conn.get("/users/#{handle}").body)['email']
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
      f.basic_auth(@user.username, @user.token)
      # f.header['Authorization'] = user.token
    end
  end
end

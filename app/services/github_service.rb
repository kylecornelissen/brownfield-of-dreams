# frozen_string_literal: true

class GithubService
  def initialize(user)
    @user = user
  end

  def repo_info
    JSON.parse(conn.get('/user/repos').body, symbolize_names: true)
  end

  def follower_info
    JSON.parse(conn.get('/user/followers').body, symbolize_names: true)
  end

  def following_info
    JSON.parse(conn.get('/user/following').body, symbolize_names: true)
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

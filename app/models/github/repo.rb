# frozen_string_literal: true

class GithubRepo
  attr_reader :path
  def initialize(data = {})
    @path = data[:full_name]
  end
end

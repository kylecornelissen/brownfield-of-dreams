# frozen_string_literal: true

require 'rails_helper'

describe 'Videos API' do
  it 'sends a single tutorial' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    create(:video, tutorial_id: tutorial.id)

    get "/api/v1/videos/#{video.id}"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:id]).to eq(video.id)
  end
end

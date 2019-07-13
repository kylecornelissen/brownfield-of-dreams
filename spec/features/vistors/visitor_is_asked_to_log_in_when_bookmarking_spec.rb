# frozen_string_literal: true

require 'rails_helper'

describe 'visitor visits video show page' do
  it 'sees a login prompt' do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to have_content('You must login to bookmark')
    click_on 'login'

    expect(current_path).to eq(login_path)
  end
end

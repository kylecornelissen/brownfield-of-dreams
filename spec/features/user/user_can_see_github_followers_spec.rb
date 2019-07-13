# frozen_string_literal: true

require 'rails_helper'

feature 'user can see github followers' do
  before :each do
    @user = create(:user)
    @user_with_token = create(:user, token: 'abc123')
  end

  scenario 'it can login and see followers with token' do
    VCR.use_cassette('services/github_service') do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_token)

      visit '/dashboard'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_css('#github_followers')

      within('#github_followers') do
        page.assert_selector('.follower')
        within(first('.follower')) do
          expect(page).to have_content('bplantico')
        end
      end
    end
  end

  scenario 'it can login and will not see followers without token' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/dashboard'

    expect(current_path).to eq('/dashboard')
    expect(page).to_not have_css('#github_followers')
  end
end

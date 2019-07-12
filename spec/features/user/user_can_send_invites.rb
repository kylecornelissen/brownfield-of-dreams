require 'rails_helper'

feature 'user can send invites' do
  scenario 'user can send invite to github handle with public email' do
    user = create(:user, token: 'abc123')
    VCR.use_cassette("services/github_service") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
    end

    VCR.use_cassette("services/github_email_request") do
      click_button "Send Invite"

      expect(current_path).to eq('/invite')

      fill_in "Handle", with: 'CosmicSpagetti'
      click_on "Send Invite"

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("Successfully sent invite!")
    end
  end

  scenario 'user cannot send invite to github handles that do not exist or do not have public email' do
    user = create(:user, token: 'abc123')
    VCR.use_cassette("services/github_service") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
    end

    VCR.use_cassette("services/github_email_request_fail") do
      click_button "Send Invite"

      expect(current_path).to eq('/invite')

      fill_in "Handle", with: 'kylecornelissen'
      click_on "Send Invite"

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end

require 'rails_helper'

feature 'user can see github following' do
  before :each do
    @user = create(:user)
    @user_with_token = create(:user, token: "a343434234324t3r")
  end

  scenario 'it can login and see following with token' do
    VCR.use_cassette("services/github_service") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_token)

      visit '/dashboard'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_css('#github_following')

      within('#github_following') do
        page.assert_selector('.following', count: 5)
        within(first('.following')) do
          expect(page).to have_content('test_user/following1')
        end
      end
    end
  end

  scenario 'it can login and will not see following without token' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/dashboard'

    expect(current_path).to eq('/dashboard')
    expect(page).to_not have_css('#github_following')
  end
end

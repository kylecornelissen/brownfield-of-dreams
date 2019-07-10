require 'rails_helper'

feature 'user can see friends' do
  before :each do
    @user = create(:user, token: 'abc123')
    @brian_user = create(:user, uid: 43261385)
    @stella_user = create(:user, uid: 43945779)
    @andrew_user = create(:user, uid: 44850604)
  end

  scenario 'it can login and see add friend button by authenticated users who are not yet friends' do
    VCR.use_cassette("services/github_service") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/dashboard'

      expect(current_path).to eq('/dashboard')

      within('#github_followers') do
        within(first('.follower')) do
          expect(page).to have_content('bplantico')
          expect(page).to have_button('Add Friend')
        end
        within('.follower:nth-child(3)') do
          expect(page).to have_content('smainar')
          expect(page).to have_button('Add Friend')
        end
        within('.follower:nth-child(4)') do
          expect(page).to have_content('CosmicSpagetti')
          expect(page).to_not have_button('Add Friend')
        end
        within('.follower:nth-child(5)') do
          expect(page).to have_content('Loomus')
          expect(page).to have_button('Add Friend')
        end
      end
    end
  end

  scenario 'it can add authenticated users as friends' do
    VCR.use_cassette("services/github_service") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit '/dashboard'
    end
      expect(current_path).to eq('/dashboard')

      within('#github_followers') do
        within(first('.follower')) do
          expect(page).to have_content('bplantico')
          expect(page).to have_button('Add Friend')
          VCR.use_cassette("services/github_service") do
          click_button "Add Friend"
          end
        end
      end

      expect(current_path).to eq('/dashboard')
      within('#github_followers') do
        within(first('.follower')) do
          expect(page).to have_content('bplantico')
          expect(page).to_not have_button('Add Friend')
        end
      end
    end
end

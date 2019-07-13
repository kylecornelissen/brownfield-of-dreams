require 'rails_helper'

RSpec.describe 'An admin can add a new tutorial' do
  let(:admin)    { create(:admin) }

  scenario 'by visiting admin new tutorial page and entering in title, description, and thumbnail fields' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in 'tutorial[title]', with: 'New Tutorial'
    fill_in 'tutorial[description]', with: 'New test tutorial fun test'
    fill_in 'tutorial[thumbnail]', with: 'https://i.ytimg.com/vi/Z0X2FyRl-9s/maxresdefault.jpg'

    click_on 'Save'
    tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content('Successfully created tutorial.')
  end

  scenario 'by visiting admin new tutorial page and miss filling out a field' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in 'tutorial[title]', with: 'New Tutorial'
    fill_in 'tutorial[description]', with: 'New test tutorial fun test'

    click_on 'Save'

    expect(current_path).to eq(new_admin_tutorial_path)
    expect(page).to have_content("There was a problem creating the tutorial.")
  end
end

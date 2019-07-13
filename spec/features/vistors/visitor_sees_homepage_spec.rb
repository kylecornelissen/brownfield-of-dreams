# frozen_string_literal: true

require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      tutorial1.videos.create!(title: "name1", description: "desc1", thumbnail: 'http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg')
      tutorial1.videos.create!(title: "name2", description: "desc2", thumbnail: 'http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg')
      tutorial2.videos.create!(title: "name3", description: "desc3", thumbnail: 'http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg')
      tutorial2.videos.create!(title: "name4", description: "desc4", thumbnail: 'http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg')

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorial')) do
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { 'hello' }
    last_name { Faker::Artist.name }
    password { Faker::Color.color_name }
    role { :default }
  end

  factory :admin, parent: :user do
    role { :admin }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :video do
    title { 'pikachu' }
    description { 'motto description test' }
    video_id { Faker::Crypto.md5 }
    tutorial
  end
end

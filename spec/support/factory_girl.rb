require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :galaxy do
    sequence(:name) { |n| "galaxy#{n}" }
    rings 2
    gm FactoryGirl.create(:user)
  end

  factory :system do
    sequence(:name) { |n| "system#{n}" }
    galaxy
    max_census 7
    raw 10
  end
end

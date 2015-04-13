require 'factory_girl'

FactoryGirl.define do
  factory :galaxy do
    sequence(:name) { |n| "galaxy#{n}" }
    rings 2
  end

  factory :system do
    sequence(:name) { |n| "system#{n}" }
    galaxy
    max_census 7
    raw 10
  end
end

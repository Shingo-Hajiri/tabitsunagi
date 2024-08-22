FactoryBot.define do
  factory :user do
    name { 'ヒノアラシ' }
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'test1234' }
    confirmed_at { Time.current }
  end
end

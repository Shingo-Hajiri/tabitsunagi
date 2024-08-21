FactoryBot.define do
  factory :spot do
    sequence(:store_name, "テスト施設1")
    introduction { 'テストテスト' }
    association :plan
  end
end
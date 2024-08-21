FactoryBot.define do
  factory :plan do
    sequence(:title, "テスト旅行プラン1")
    body { 'テストテスト' }
    association :user
  end
end
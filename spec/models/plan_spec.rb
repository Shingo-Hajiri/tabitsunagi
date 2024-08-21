require 'rails_helper'

RSpec.describe Plan, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'バリデーションチェック' do
    it '設定したバリデーションがすべて機能しているか' do
      plan = build(:plan)
      expect(plan).to be_valid
      expect(plan.errors).to be_empty
    end

    it 'titleがない場合にバリデーションエラーが機能しているか' do
      plan_without_title = build(:plan, title: '')
      expect(plan_without_title).to be_invalid
      expect(plan_without_title.errors[:title]).to eq ["を入力してください"]
    end

    it 'bodyがない場合にバリデーションエラーが機能しているか' do
      plan_without_body = build(:plan, body: '')
      expect(plan_without_body).to be_invalid
      expect(plan_without_body.errors[:body]).to eq ["を入力してください"]
    end

    it 'titleの値が50文字以上の場合にバリデーションエラーが機能しているか' do
      plan_length_over_title = build(:plan, title: "あ" * 256)
      expect(plan_length_over_title).to be_invalid
      expect(plan_length_over_title.errors[:title]).to eq ["は50文字以内で入力してください"]
    end

    it 'bodyの値が65,536文字以上の場合にバリデーションエラーが機能しているか' do
      plan_length_over_body = build(:plan, body: "あ" * 65536)
      expect(plan_length_over_body).to be_invalid
    end
  end
end

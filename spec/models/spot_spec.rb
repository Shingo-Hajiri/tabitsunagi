require 'rails_helper'

RSpec.describe Spot, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'バリデーションチェック' do
    it '設定したバリデーションがすべて機能しているか' do
      spot = build(:spot)
      expect(spot).to be_valid
      expect(spot.errors).to be_empty
    end

    it 'store_nameがない場合にバリデーションエラーが機能しているか' do
      spot_without_store_name = build(:spot, store_name: '')
      expect(spot_without_store_name).to be_invalid
      expect(spot_without_store_name.errors[:store_name]).to eq ["を入力してください"]
    end

    it 'introductionがない場合にバリデーションエラーが機能しているか' do
      spot_without_introduction = build(:spot, introduction: '')
      expect(spot_without_introduction).to be_invalid
      expect(spot_without_introduction.errors[:introduction]).to eq ["を入力してください"]
    end

    it 'store_nameの値が256文字以上の場合にバリデーションエラーが機能しているか' do
      spot_length_over_store_name = build(:spot, store_name: "あ" * 256)
      expect(spot_length_over_store_name).to be_invalid
      expect(spot_length_over_store_name.errors[:store_name]).to eq ["は255文字以内で入力してください"]
    end

    it 'introductionの値が65,536文字以上の場合にバリデーションエラーが機能しているか' do
      spot_length_over_introduction = build(:spot, introduction: "あ" * 65_536)
      expect(spot_length_over_introduction).to be_invalid
    end
  end
end

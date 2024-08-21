require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'バリデーションチェック' do
    it '設定したバリデーションがすべて機能しているか' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'nameがない場合にバリデーションエラーが機能しているか' do
      user_without_name = build(:user, name: "")
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors[:name]).to eq ["を入力してください"]
    end

    it 'emailがない場合にバリデーションエラーが機能しているか' do
      user_without_email = build(:user, email: "")
      expect(user_without_email).to be_invalid
      expect(user_without_email.errors[:email]).to eq ["を入力してください"]
    end

    it 'passwordがない場合にバリデーションエラーが機能しているか' do
      user_without_password = build(:user, password: "")
      expect(user_without_password).to be_invalid
      expect(user_without_password.errors[:password]).to eq ["を入力してください"]
    end

    it 'nameの値が256文字以上の場合にバリデーションエラーが機能しているか' do
      user_length_over_name = build(:user, name: "あ" * 256)
      expect(user_length_over_name).to be_invalid
      expect(user_length_over_name.errors[:name]).to eq ["は255文字以内で入力してください"]
    end

    it 'passwordの値が6文字未満の場合にバリデーションエラーが機能しているか' do
      user_length_missing_password = build(:user, password: "a" * 3)
      expect(user_length_missing_password).to be_invalid
      expect(user_length_missing_password.errors[:password]).to eq ["は6文字以上で入力してください"]
    end
  end
end

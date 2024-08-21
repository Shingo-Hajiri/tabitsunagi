require 'rails_helper'

RSpec.describe "Users", type: :system do

  let(:user) { create(:user) }

  # pending "add some scenarios (or delete) #{__FILE__}"
  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する', js: true do
          visit root_path
          find('#open').click
          find('#close').click
          find('#open').click
          click_link 'アカウント登録'
          fill_in 'ユーザー名', with: 'ヒノアラシ'
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'test1234'
          fill_in 'パスワード（確認用）', with: 'test1234'
          click_button 'アカウント登録'
          expect(page).to have_content 'アカウント登録が完了しました。'
          expect(current_path).to eq root_path
        end
      end

      context 'すべての項目が未入力' do
        it 'ユーザーの新規登録に失敗する' do
          visit new_user_registration_path
          fill_in 'ユーザー名', with: ''
          fill_in 'Eメール', with: ''
          fill_in 'パスワード', with: ''
          fill_in 'パスワード（確認用）', with: ''
          click_button 'アカウント登録'
          expect(page).to have_content '3 件のエラーが発生したため ユーザー は保存されませんでした。'
          expect(page).to have_content 'ユーザー名を入力してください'
          expect(page).to have_content 'Eメールを入力してください'
          expect(page).to have_content 'パスワードを入力してください'
          # postのパスにする
          expect(current_path).to eq new_user_registration_path
        end
      end

      context 'ユーザー名が未入力' do
        it 'ユーザーの新規登録に失敗する' do
          visit new_user_registration_path
          fill_in 'ユーザー名', with: ''
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'test1234'
          fill_in 'パスワード（確認用）', with: 'test1234'
          click_button 'アカウント登録'
          expect(page).to have_content '1 件のエラーが発生したため ユーザー は保存されませんでした。'
          expect(page).to have_content 'ユーザー名を入力してください'
          expect(current_path).to eq new_user_registration_path
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規登録に失敗する' do
          visit new_user_registration_path
          fill_in 'ユーザー名', with: 'ヒノアラシ'
          fill_in 'Eメール', with: ''
          fill_in 'パスワード', with: 'test1234'
          fill_in 'パスワード（確認用）', with: 'test1234'
          click_button 'アカウント登録'
          expect(page).to have_content '1 件のエラーが発生したため ユーザー は保存されませんでした。'
          expect(page).to have_content 'Eメールを入力してください'
          expect(current_path).to eq new_user_registration_path
        end
      end

      context '登録済みのメールアドレスを使用' do
        it 'ユーザーの新規登録に失敗する' do
          existed_user = create(:user)
          visit new_user_registration_path
          fill_in 'ユーザー名', with: 'ヒノアラシ'
          fill_in 'Eメール', with: existed_user.email
          fill_in 'パスワード', with: 'test1234'
          fill_in 'パスワード（確認用）', with: 'test1234'
          click_button 'アカウント登録'
          expect(page).to have_content '1 件のエラーが発生したため ユーザー は保存されませんでした。'
          expect(page).to have_content 'Eメールはすでに存在します'
          expect(current_path).to eq new_user_registration_path
        end
      end

      context 'パスワードが未入力' do
        it 'ユーザーの新規登録に失敗する' do
          visit new_user_registration_path
          fill_in 'ユーザー名', with: 'ヒノアラシ'
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: ''
          fill_in 'パスワード（確認用）', with: ''
          click_button 'アカウント登録'
          expect(page).to have_content '1 件のエラーが発生したため ユーザー は保存されませんでした。'
          expect(page).to have_content 'パスワードを入力してください'
          expect(current_path).to eq new_user_registration_path
        end
      end

      context 'パスワードとパスワード（確認用）の値が異なる' do
        it 'ユーザーの新規登録に失敗する' do
          visit new_user_registration_path
          fill_in 'ユーザー名', with: 'ヒノアラシ'
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'test1234'
          fill_in 'パスワード（確認用）', with: 'test5678'
          click_button 'アカウント登録'
          expect(page).to have_content '1 件のエラーが発生したため ユーザー は保存されませんでした。'
          expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
          expect(current_path).to eq new_user_registration_path
        end
      end

      context 'パスワードの値が6文字未満' do
        it 'ユーザーの新規登録に失敗する' do
          visit new_user_registration_path
          fill_in 'ユーザー名', with: 'ヒノアラシ'
          fill_in 'Eメール', with: 'test@example.com'
          fill_in 'パスワード', with: 'test1'
          fill_in 'パスワード（確認用）', with: 'test1'
          click_button 'アカウント登録'
          expect(page).to have_content '1 件のエラーが発生したため ユーザー は保存されませんでした。'
          expect(page).to have_content 'パスワードは6文字以上で入力してください'
          expect(current_path).to eq new_user_registration_path
        end
      end
    end
  end
end

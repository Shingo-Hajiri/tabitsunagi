require 'rails_helper'

RSpec.describe "UserSessions", type: :system do

  let(:user) { create(:user) }

  # pending "add some scenarios (or delete) #{__FILE__}"
  describe 'ログイン前' do
    describe 'メニューの表示' do
      context 'ログイン前のメニュー表示' do
        it 'ログイン前のメニューが表示される', js: true do
          visit root_path
          # find('#open').click
          expect(page).to have_content '投稿する'
          expect(page).to have_content 'みんなのおすすめ旅'
          expect(page).to have_content '旅行の計画を立てる'
          expect(page).to have_content '(外部サイトに移動します)'
          expect(page).to have_content 'アカウント登録'
          expect(page).to have_content 'ログイン'
          expect(page).to have_content 'サイトについて'
          # find('#close').click
          # expect(current_path).to eq root_path
        end
      end

      context 'フォームが正常' do
        it 'ログイン処理が成功する' do
          visit new_user_session_path
          fill_in 'Eメール', with: user.email
          fill_in 'パスワード', with: user.password
          click_button 'ログイン'
          expect(page).to have_content 'ログインしました。'
          expect(current_path).to eq root_path
        end
      end

      context 'フォームが未入力' do
        it 'ログイン処理が失敗する' do
          # visit root_path
          # find('.svg-inline--fa.fa-right-to-bracket.fa-xl').click
          visit new_user_session_path
          fill_in 'Eメール', with: ''
          fill_in 'パスワード', with: ''
          click_button 'ログイン'
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
          expect(current_path).to eq new_user_session_path
        end
      end

      context 'メールアドレスとパスワードの組み合わせが違う' do
        it 'ログイン処理が失敗する' do
          visit new_user_session_path
          # find('.svg-inline--fa.fa-right-to-bracket.fa-xl').click
          fill_in 'Eメール', with: user.email
          fill_in 'パスワード', with: 'test5678'
          click_button 'ログイン'
          expect(page).to have_content 'Eメールまたはパスワードが違います。'
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe 'メニューの表示' do
      context 'ログイン後のメニュー表示' do
        it 'ログイン後のメニューが表示される' do
          visit root_path
          # find('#open').click
          expect(page).to have_content user.name
          expect(page).to have_content '投稿する'
          expect(page).to have_content '私のおすすめ旅'
          expect(page).to have_content 'みんなのおすすめ旅'
          expect(page).to have_content 'お気に入り'
          expect(page).to have_content '旅行の計画を立てる'
          expect(page).to have_content '(外部サイトに移動します)'
          expect(page).to have_content 'ログアウト'
          # find('#close').click
          expect(current_path).to eq root_path
        end
      end
    end
  end
end

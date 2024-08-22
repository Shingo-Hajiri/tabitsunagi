require 'rails_helper'

RSpec.describe "Plans", type: :system do

  let(:user) { create(:user) }

  # pending "add some scenarios (or delete) #{__FILE__}"
  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context '投稿画面へのアクセス' do
        it '投稿ページへのアクセスに失敗する' do
          visit new_plan_path
          expect(page).to have_content 'ログインもしくはアカウント登録してください。'
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe 'おすすめ旅投稿(デフォルトのフォームのみ)' do
      context 'フォームが正常' do
        it 'おすすめ旅投稿が成功する' do
          visit root_path
          visit new_plan_path
          fill_in 'タイトル', with: 'テスト'
          fill_in '内容', with: 'テストおすすめ旅'
          find("input[name='plan[spots_attributes][0][store_name]']").set('テスト施設名')
          find("textarea[name='plan[spots_attributes][0][introduction]']").set('テストおすすめポイント')
          click_button '投稿する'
          expect(page).to have_content 'おすすめ旅を投稿しました！'
          expect(current_path).to eq complete_plans_path
        end
      end

      context 'タイトルが未入力' do
        it 'おすすめ旅投稿が失敗する' do
          visit new_plan_path
          fill_in 'タイトル', with: ''
          fill_in '内容', with: 'テストおすすめ旅'
          find("input[name='plan[spots_attributes][0][store_name]']").set('テスト施設名')
          find("textarea[name='plan[spots_attributes][0][introduction]']").set('テストおすすめポイント')
          click_button '投稿する'
          expect(page).to have_content 'おすすめ旅を投稿できませんでした。'
          expect(current_path).to eq new_plan_path
        end
      end

      context '内容が未入力' do
        it 'おすすめ旅投稿が失敗する' do
          visit new_plan_path
          fill_in 'タイトル', with: 'テスト'
          fill_in '内容', with: ''
          find("input[name='plan[spots_attributes][0][store_name]']").set('テスト施設名')
          find("textarea[name='plan[spots_attributes][0][introduction]']").set('テストおすすめポイント')
          click_button '投稿する'
          expect(page).to have_content 'おすすめ旅を投稿できませんでした。'
          expect(current_path).to eq new_plan_path
        end
      end

      context '施設名が未入力' do
        it 'おすすめ旅投稿が失敗する' do
          visit new_plan_path
          fill_in 'タイトル', with: 'テスト'
          fill_in '内容', with: 'テストおすすめ旅'
          find("input[name='plan[spots_attributes][0][store_name]']").set('')
          find("textarea[name='plan[spots_attributes][0][introduction]']").set('テストおすすめポイント')
          click_button '投稿する'
          expect(page).to have_content 'おすすめ旅を投稿できませんでした。'
          expect(current_path).to eq new_plan_path
        end
      end

      context 'おすすめポイントが未入力' do
        it 'おすすめ旅投稿が失敗する' do
          visit new_plan_path
          fill_in 'タイトル', with: 'テスト'
          fill_in '内容', with: 'テストおすすめ旅'
          find("input[name='plan[spots_attributes][0][store_name]']").set('テスト施設名')
          find("textarea[name='plan[spots_attributes][0][introduction]']").set('')
          click_button '投稿する'
          expect(page).to have_content 'おすすめ旅を投稿できませんでした。'
          expect(current_path).to eq new_plan_path
        end
      end
    end

    # describe 'おすすめ旅投稿(フォームの追加)' do
    #   context '追加したフォームが正常' do
    #     it 'おすすめ旅投稿が成功する' do
    #       visit new_plan_path
    #       fill_in 'タイトル', with: 'テスト'
    #       fill_in '内容', with: 'テストおすすめ旅'
    #       find("input[name='plan[spots_attributes][0][store_name]']").set('テスト施設名1')
    #       find("textarea[name='plan[spots_attributes][0][introduction]']").set('テストおすすめポイント1')
    #       expect(page).to have_selector('.spot-fields', count: 2)
    #       find('.svg-inline--fa.fa-circle-plus.fa-4x.cursor-pointer').click
    #       expect(page).to have_selector('.spot-fields', count: 3)

    #       within("#spots") do
    #         find("#store").set('')
    #         fill_in 'おすすめポイント', with: ''
    #       end
    #       click_button '投稿する'
    #       expect(page).to have_content 'おすすめ旅を投稿しました！'
    #       expect(current_path).to eq complete_plans_path
    #     end
    #   end
    # end

    # describe 'おすすめ旅投稿(オートコンプリート機能)' do
    #   context '施設名に値を入力する' do
    #     it '予測リスト内の値が反映される' do
    #       visit new_plan_path
    #       fill_in 'タイトル', with: 'テスト'
    #       fill_in '内容', with: 'テストおすすめ旅'
    #       find("input[name='plan[spots_attributes][0][store_name]']").set('東京')
    #       expect(page).to have_selector('.pac-item', visible: true)
    #       first('.pac-item').click
    #       expect(find("input[name='plan[spots_attributes][0][store_name]']").value).to_not eq '東京'
    #     end
    #   end
    # end
  end
end

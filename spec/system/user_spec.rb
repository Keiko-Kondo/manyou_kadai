require 'rails_helper'
describe 'ユーザー機能', type: :system do
    context 'ユーザーを登録した場合' do
      it '新規で登録がされる' do
        FactoryBot.create(:user, name: "管理者")
        visit new_session_path
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
        visit new_admin_user_path
        fill_in 'Name', with: 'テストユーザー'
        fill_in 'Email', with: 'test@test.com'
        select '有', from: 'user[admin]'
        fill_in 'Password', with: '111111'
        fill_in 'Password confirmation', with: '111111'
        click_on 'ユーザー作成'
        visit admin_users_path
       expect(page).to have_content 'テストユーザー'
     end
   end

   context 'ユーザーがログインせずタスク一覧画面にアクセスした場合' do
     it 'ログイン画面に遷移する' do
       FactoryBot.create(:user, name: "管理者")
       visit tasks_path
       expect(page).to have_content 'ログインしてください'
    end
  end
end

  describe 'セッション機能', type: :system do
      context 'ログインした場合' do
        it 'ログインされた状態になる' do
          FactoryBot.create(:user, name: "管理者")
          visit new_session_path
          fill_in 'Email', with: 'admin@admin.com'
          fill_in 'Password', with: '111111'
          click_on 'Log in'
          expect(page).to have_content '管理者のページ'
       end
     end

     context 'ユーザーがログインし、詳細ページに飛んだ場合' do
       it '詳細ページが表示される' do
         user = FactoryBot.create(:user, name: "管理者")
         visit new_session_path
         fill_in 'Email', with: 'admin@admin.com'
         fill_in 'Password', with: '111111'
         click_on 'Log in'
         visit user_path(user.id)
         expect(page).to have_content 'admin@admin.com'
      end
    end

    context '一般ユーザーが他人の詳細画面に飛ぼうとした場合' do
      it 'タスク一覧画面に遷移する' do
        user = FactoryBot.create(:user, name: "管理者")
        FactoryBot.build(:user, name: "ユーザー")
        visit new_session_path
        fill_in 'Email', with: 'user@user.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
        get 'http://localhost:3000/users/user.id/url'
        expect(response).to redirect_to("http://localhost:3000/tasks")

     end
   end

     context 'ログアウトボタンを押した場合' do
       it 'ログアウトされる' do
         user = FactoryBot.create(:user, name: "管理者")
         visit new_session_path
         fill_in 'Email', with: 'admin@admin.com'
         fill_in 'Password', with: '111111'
         click_on 'Log in'
         click_on 'Logout'
         expect(page).to have_content 'ログアウトしました'

      end
   end

end

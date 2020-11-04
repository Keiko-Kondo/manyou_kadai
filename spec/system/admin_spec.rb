require 'rails_helper'
describe '管理画面', type: :system do

 describe '管理者機能' do

  before do
    FactoryBot.create(:user, name: "管理者")
    visit new_session_path
    fill_in 'Email', with: 'admin@admin.com'
    fill_in 'Password', with: '111111'
    click_on 'Log in'

  end


    context '管理ユーザーが管理画面にアクセスした場合' do
      it '管理画面が表示される' do
        visit admin_users_path
        expect(page).to have_content '管理者用のユーザー一覧画面だよ'
     end
   end


  context '管理ユーザーがユーザーを新規登録した場合' do
    it '新規登録され、ユーザー一覧に表示される' do
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

  context '管理ユーザーがユーザーの詳細画面にアクセスした場合' do
    it '詳細画面が表示される' do
      user = FactoryBot.create(:second_user, name: "ユーザー")
      # visit admin_users_path
      visit admin_user_path(user.id)
      expect(page).to have_content 'ユーザーのページ'

   end
  end

  context '管理ユーザーがユーザーの編集画面にアクセスした場合' do
    it 'ユーザーを編集できる' do
      user = FactoryBot.create(:second_user, name: "ユーザー")
      visit edit_admin_user_path(user.id)
      fill_in 'Name', with: 'ユーザー更新'
      fill_in 'Email', with: 'user@user.com'
      select '有', from: 'user[admin]'
      fill_in 'Password', with: '111111'
      fill_in 'Password confirmation', with: '111111'
      click_on 'ユーザー更新'
      visit admin_users_path
      expect(page).to have_content 'ユーザー更新'

   end
  end

  context '管理ユーザーがユーザーを削除した場合' do
    it 'ユーザーが削除される' do
      @user = FactoryBot.create(:second_user, name: "ユーザー")
      visit admin_users_path
      all('tbody tr')[1].click_link 'Destroy'
      page.driver.browser.switch_to.alert.accept
      # save_and_open_page
      # delete :destroy, params: { id: @user.id }
      # visit admin_users_path
      expect(current_path).to eq admin_users_path
      expect(all('tbody tr')[1]).not_to have_content "#{@user.name}"
   end
  end

end


describe '一般ユーザー機能' do
  context '一般ユーザーが管理画面にアクセスした場合' do
    it 'アクセスできずタスク一覧が表示される' do
      FactoryBot.create(:second_user, name: "ユーザー")
      visit new_session_path
      fill_in 'Email', with: 'user@user.com'
      fill_in 'Password', with: '111111'
      click_on 'Log in'
      visit admin_users_path
      expect(page).to have_content 'タスク一覧'
 end

end

end
end

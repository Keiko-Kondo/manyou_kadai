require 'rails_helper'
describe 'タスク管理機能', type: :system do

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        visit new_session_path
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        user = FactoryBot.create(:user)
        FactoryBot.create(:task, user: user)
        FactoryBot.create(:second_task, user: user)
        visit new_session_path
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
        visit tasks_path
        task_list = all('.task_index')
        expect(task_list[0]).to have_content 'test_task2'
        expect(task_list[1]).to have_content 'test_task1'
      end
    end
    context '終了期限でソートするというリンクを押した場合' do
      it '終了期限の降順に並び替えられたタスク一覧が表示される' do
        user = FactoryBot.create(:user)
        FactoryBot.create(:task, user: user)
        FactoryBot.create(:second_task, user: user)
        visit new_session_path
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
        visit tasks_path
        click_on '終了期限でソートする'
        deadline_list = all('.deadline_index')
        expect(deadline_list[0]).to have_content "2020-10-01 00:00:00 +0900"
        expect(deadline_list[1]).to have_content "2020-10-02 00:00:00 +0900"
      end
    end
  end

  describe '検索機能' do
    before do
      user = FactoryBot.create(:user)
      FactoryBot.create(:task, task_name: "task", user: user)
      FactoryBot.create(:second_task, task_name: "sample", user: user)
      visit new_session_path
      fill_in 'Email', with: 'admin@admin.com'
      fill_in 'Password', with: '111111'
      click_on 'Log in'
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'search[task_name]', with: 'task'
        click_on '検索'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '完了', from: 'search[status]'
        click_on '検索'
        expect(page).to have_content '完了'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'search[task_name]', with: 'sample'
        select '未着手', from: 'search[status]'
        expect(page).to have_content 'sample'
        expect(page).to have_content '未着手'
      end
    end
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクと終了期限とステータスが表示される' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
        task = FactoryBot.create(:second_task, task_name: 'タスク例', user: user)
        visit tasks_path
        expect(page).to have_content 'タスク例'
        expect(page).to have_content '2020-10-01'
        expect(page).to have_content '完了'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
        task = FactoryBot.create(:task, task_name: 'task', user: user)
        visit tasks_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end


end

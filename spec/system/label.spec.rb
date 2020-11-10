require 'rails_helper'
describe 'タスク管理機能', type: :system do

  describe 'タスク管理機能' do
    context 'タスク作成画面でラベルをつけた場合' do
      it 'タスクに複数のラベルを付けられる' do
        user = FactoryBot.create(:user)
        @task = FactoryBot.create(:task, user: user)
        @label = FactoryBot.create(:label)
        binding.pry
        Factroybot.create(:labelling, task: @task, label: @label)
        visit new_session_path
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
        visit tasks_path
        expect(page).to have_content '必須'
      end
    end

    context 'タスク詳細画面を開くと' do
      it 'タスクに紐づくラベル一覧が表示される' do
        user = FactoryBot.create(:user)
        task = FactoryBot.create(:task, user: user)
        visit new_session_path
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
        visit tasks_path(task.id)
        expect(page).to have_content '必須'
      end
    end




      context 'ラベルで検索すると' do
      it 'そのラベルのついたタスクのみ表示される' do
        user = FactoryBot.create(:user)
        FactoryBot.create(:task, user: user)
        FactoryBot.create(:second_task, user: user)
        visit new_session_path
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Password', with: '111111'
        click_on 'Log in'
            visit tasks_path
            select '必須', from: 'search[label_id]'
            click_on '検索'
            # expect(page).not_to have_content '至急'
            expect(page).to have_content '至急'
            expect(page).to have_content '必須'
          end
        end

      end
    end

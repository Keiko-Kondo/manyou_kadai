require 'rails_helper'
describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task,  task_name: 'task')
        visit tasks_path
       expect(page).to have_content 'task'
     end
   end
   context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task,  task_name: 'task1')
        FactoryBot.create(:task,  task_name: 'task2')
        visit tasks_path
        task_list = all('.task_index')
        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task1'
      end
    end
    context '終了期限でソートするというリンクを押した場合' do
       it '終了期限の降順に並び替えられたタスク一覧が表示される' do
         FactoryBot.create(:task)
         FactoryBot.create(:second_task)
         # fill_in 'task[deadline]', with: '20201002'
         # fill_in 'task[deadline]', with: '20201001'
         visit tasks_path
         click_on '終了期限でソートする'
         deadline_list = all('.deadline_index')
         expect(deadline_list[0]).to have_content "2020-10-01 00:00:00 +0900"
         expect(deadline_list[1]).to have_content "2020-10-02 00:00:00 +0900"
       end
     end

     describe '検索機能' do
       before do
         # 必要に応じて、テストデータの内容を変更して構わない
         FactoryBot.create(:task, task_name: "task")
         FactoryBot.create(:second_task, task_name: "sample")
       end
       context 'タイトルであいまい検索をした場合' do
         it "検索キーワードを含むタスクで絞り込まれる" do
           visit tasks_path
           # タスクの検索欄に検索ワードを入力する (例: task)
           fill_in 'search[task_name]', with: 'task'
           # 検索ボタンを押す
           click_on '検索'
           expect(page).to have_content 'task'
         end
       end
       context 'ステータス検索をした場合' do
         it "ステータスに完全一致するタスクが絞り込まれる" do
           # ここに実装する
           # プルダウンを選択する「select」について調べてみること
           visit tasks_path
           select '完了', from: 'search[status]'
           click_on '検索'
           expect(page).to have_content '完了'
         end
       end
       context 'タイトルのあいまい検索とステータス検索をした場合' do
         it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
           # ここに実装する
           visit tasks_path
           fill_in 'search[task_name]', with: 'sample'
           select '未着手', from: 'search[status]'
           expect(page).to have_content 'sample'
           expect(page).to have_content '未着手'
         end
       end
     end
  end
end


 describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクと終了期限とステータスが表示される' do
      # 1. new_task_pathに遷移する（新規作成ページに遷移する）
      # ここにnew_task_pathにvisitする処理を書く
      visit new_task_path
      # 2. 新規登録内容を入力する
      #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
      # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      fill_in 'task[task_name]', with: 'タスク例'
      # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
      fill_in 'task[details]', with: '詳細例'
      fill_in 'task[deadline]', with: '20201001'
      select '完了', from: 'task[status]'
      # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
      # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
      click_on '登録'
      # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
      # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
      # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
      expect(page).to have_content 'タスク例'
      expect(page).to have_content '2020-10-01'
      expect(page).to have_content '完了'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, task_name: 'task')
         # タスク一覧ページに遷移
         visit tasks_path(task.id)
        expect(page).to have_content 'task'
       end
     end
  end

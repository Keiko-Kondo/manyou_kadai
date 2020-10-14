require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(task_name: '', details: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(details: nil)
        task.valid?
        expect(task.errors[:details]).to include("を入力してください")
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(
          task_name: 'テストタスク',
          details: 'テスト詳細')
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task){FactoryBot.create(:task)}
    let!(:second_task){FactoryBot.create(:second_task)}
    # before do
    #   task = FactoryBot.create(:task)
    #   second_task = FactoryBot.create(:second_task)
    # end
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.task_like('task1')).to include(task)
        expect(Task.task_like('task1')).not_to include(second_task)
        expect(Task.task_like('task1').count).to eq 1
      end
  end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_is('着手中')).to include(task)
        expect(Task.status_is('着手中')).not_to include(second_task)
        expect(Task.status_is('着手中').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        jyouken  = (Task.task_like('task1')) && (Task.status_is('着手中'))
        expect(jyouken).to include(task)
        expect(jyouken).not_to include(second_task)
        expect((jyouken).count).to eq 1
      end
    end
  end
end

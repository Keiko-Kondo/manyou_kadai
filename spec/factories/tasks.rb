FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    task_name { 'test_title' }
    details { 'test_content' }
  end
end
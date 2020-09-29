FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    task_name { 'test_task1' }
    details { 'test_details1' }
  end
  factory :second_task, class: Task do
    task_name { 'test_task2' }
    details { 'test_details2' }
  end
end

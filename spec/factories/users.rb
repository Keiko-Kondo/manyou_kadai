FactoryBot.define do
  factory :user do
      name {  '管理者' }
      email { 'admin@admin.com' }
      admin { true }
      password { '111111' }
      password_confirmation { '111111' }
    end
  factory :second_user, class: User do
    name { 'ユーザー' }
    email { 'user@user.com' }
    admin { false }
    password { '111111' }
    password_confirmation { '111111' }
    end
end

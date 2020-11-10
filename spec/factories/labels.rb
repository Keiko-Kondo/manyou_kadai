FactoryBot.define do
  factory :label do

    name { "必須" }
  end
  factory :second_label, class: Label do
    name { "至急" }
  end
end

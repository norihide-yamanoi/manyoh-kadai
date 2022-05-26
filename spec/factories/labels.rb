FactoryBot.define do
  factory :label do
    name { "朝" }
  end
  factory :label2, class: Label do
    name { '昼' }
  end

end

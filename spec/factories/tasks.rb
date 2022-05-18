FactoryBot.define do
  factory :task do
    name { 'Factoryで作ったデフォルトのタイトル１' }
    detail { 'Factoryで作ったデフォルトのコンテント１' }
  end
  factory :second_task, class: Task do
    name { 'Factoryで作ったデフォルトのタイトル２' }
    detail { 'Factoryで作ったデフォルトのコンテント２' }
  end
end

FactoryBot.define do
  factory :task do
    name { 'テストネーム０１' }
    detail { 'テストディティール０１' }
    dead_line { '2020-05-05'}
    status {'完了'}
    priority {'低'}

    after(:build) do |task|
      label = create(:label)
      task.labellings << build(:labelling, task: task, label: label)
    end
  end
  factory :second_task, class: Task do
    name { 'テストネーム０２' }
    detail { 'テストディティール０２' }
    dead_line { '2023-01-01'}
    status {'未着手'}
    priority {'高'}
  end
end

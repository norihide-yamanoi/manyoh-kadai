FactoryBot.define do
  factory :admin_user, class: User do
    name { 'dog' }
    email { "wanwan@wan.com" }
    password { "wanwan" }
    admin {'ture'}
  end
  factory :ordinary_user, class: User do
    name { 'cat' }
    email { "nyannyan@nyan.com" }
    password { "nyannyan" }
    admin {'false'}
  end
end

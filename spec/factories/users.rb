FactoryBot.define do
  factory :user do
    name { 'dog' }
    email { "wanwan@wan.com" }
    password { "wanwan" }
    admin {'ture'}
  end
end

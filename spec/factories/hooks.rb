FactoryGirl.define do
  factory :hook, class: 'ZapierRestHooks::Hook' do
    event_name "MyString"
    owner_id 0
    owner_class_name "Struct::ZapierApp"
    subscription_url "MyString"
    target_url "MyString"
  end
end

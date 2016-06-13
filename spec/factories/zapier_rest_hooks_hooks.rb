FactoryGirl.define do
  factory :zapier_rest_hooks_hook, class: 'ZapierRestHooks::Hook' do
    event "MyString"
    account_id "MyString"
    subscription_url "MyString"
    target_url "MyString"
  end
end

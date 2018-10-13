FactoryBot.define do
  factory :candidate do
    organization
    first_name { 'MyString' }
    last_name { 'MyString' }
    email { 'MyString' }
  end
end

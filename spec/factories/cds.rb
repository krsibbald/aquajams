# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cd do
    name "MyString"
    code 1
    time_in_sec 1
  end
end

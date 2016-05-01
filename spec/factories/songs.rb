# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :song do
    name "MyString"
    artist nil
    length_in_sec 1
    year 1
    top_billboard_spot 1
    billboard_weeks "9.99"
  end
end

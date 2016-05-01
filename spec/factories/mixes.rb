# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mix do
    name "MyString"
    length_in_sec 1
    recorded_at "2016-04-30"
    description "MyText"
    source "MyText"
    music_type "MyText"
    notes "MyText"
  end
end

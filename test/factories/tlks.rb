FactoryBot.define do
  factory :tlk do
    sequence(:title) { |n| "title#{n}" }
  end
end

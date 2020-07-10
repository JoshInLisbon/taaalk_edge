FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "2email#{n}@email.com" }
    sequence(:username) { |n| "2first-name#{n} last-name#{n}" }
    sequence(:password) { |n| "2password#{n}" }
  end
end

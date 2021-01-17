FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test#{n}"}
    sequence(:emai) {|n| "test#{n}@example.com"}
    password {"123456"}
    password_confirmation {"123456"}
  end
end

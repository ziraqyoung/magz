FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyText" }
    user { nil }
    category { nil }
  end
end

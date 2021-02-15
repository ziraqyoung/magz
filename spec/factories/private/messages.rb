FactoryBot.define do
  factory :private_message, class: 'Private::Message' do
    message_body { 'a' * 20 }
    association :messagable, factory: :private_conversation
    user
  end
end

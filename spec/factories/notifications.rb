FactoryBot.define do
  factory :notification do
    association :notifiable, factory: :contact # use contact as in sent to contact request hence notification
    association :recipient, factory: :user
    association :actor, factory: :user 
    action { "sent" }
    read_at { nil }
  end
end

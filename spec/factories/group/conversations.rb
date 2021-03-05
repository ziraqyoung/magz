FactoryBot.define do
  factory :group_conversation, class: 'Group::Conversation' do
    sequence(:name) { |n| "group_#{n}" }
  end
end

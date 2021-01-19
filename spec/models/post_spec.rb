require 'rails_helper'

RSpec.describe Post, type: :model do
  context "Association" do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq(:belongs_to)
    end

    it 'belongs_to category' do
      association = described_class.reflect_on_association(:category).macro
      expect(association).to eq(:belongs_to)
    end
  end
end

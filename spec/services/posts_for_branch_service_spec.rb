require 'rails_helper'

describe PostsForBranchService do
  context "#call" do
    let(:not_included_posts) { create_list(:post, 2) }
    let(:category) { create(:category, branch: 'hobby', name: 'arts') }
    let(:post) { create(:post, title: 'A very fun post', category_id: category.id) }

    it 'returns posts filtered by branch' do
      not_included_posts
      category
      included_posts = create_list(:post, 2, category_id: category.id)
      expect(PostsForBranchService.new({branch: 'hobby'}).call).to match_array(included_posts)
    end

    it 'returns posts filtered by branch and search input' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new({ branch: 'hobby', search: 'fun' }).call).to eq(included_post)
    end

    it 'returns posts filtered by category name' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new({ branch: 'hobby', category: 'arts' }).call).to eq(included_post)
    end

    it 'returns posts filtered by category and search input' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new({ branch: 'hobby', category: 'arts', search: 'fun' }).call).to eq(included_post)
    end
  end
end

require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  context '#create_new_post_partial_path' do
    it "returns a signed_in partial's path" do
      allow(helper).to receive(:user_signed_in?).and_return(true)
      expect(helper.create_new_post_partial_path).to eq('posts/branch/create_new_post/signed_in')
    end

    it "returns not_signed_in partial's path" do
      allow(helper).to receive(:user_signed_in?).and_return(false)
      expect(helper.create_new_post_partial_path).to eq('posts/branch/create_new_post/not_signed_in')
    end
  end

  context '#all_categories_button_partial_path' do
    it "returns all_selected partial's path" do
      controller.params[:category] = ''
      expect(helper.all_categories_button_partial_path).to eq('posts/branch/categories/all_selected')
    end

    it "returns all_no_selected partial's path" do
      controller.params[:category] = 'category'
      expect(helper.all_categories_button_partial_path).to eq('posts/branch/categories/all_not_selected')
    end
  end

  context "#no_posts_partial_path" do
    it "return no_posts partial's path" do
      assign(:posts, [])
      expect(helper.no_posts_partial_path).to eq('posts/branch/no_posts')
    end

    it "returns empty partial's path" do
      assign(:posts, [1])
      expect(helper.no_posts_partial_path).to eq("shared/empty_partial")
    end
  end
end

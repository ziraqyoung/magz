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
      expect(helper.no_posts_partial_path([])).to eq('posts/shared/no_posts')
    end

    it "returns empty partial's path" do
      assign(:posts, [1])
      expect(helper.no_posts_partial_path([1])).to eq("shared/empty_partial")
    end
  end

  context "#post_format_partial_path" do
    it "returns a home_page partial's path" do
      allow(helper).to receive(:current_page?).and_return(true)
      expect(helper.post_format_partial_path).to eq("posts/post/home_page")
    end

    it "returns a branch_page partial's path" do
      allow(helper).to receive(:current_page?).and_return(false)
      expect(helper.post_format_partial_path).to eq("posts/post/branch_page")
    end
  end

  context "#contact_user_partial_path" do
    before(:each) do
      @current_user = create(:user, id: 1)
      allow(helper).to receive(:current_user).and_return(@current_user)
    end

    it "returns contact_user partial's path" do
      allow(helper).to receive(:user_signed_in?).and_return(true)
      assign(:post, create(:post, user: create(:user, id: 2)))
      expect(helper.contact_user_partial_path).to eq('posts/show/contact_user')
    end

    it "returns empty_partial partial's path" do
      allow(helper).to receive(:user_signed_in?).and_return(true)
      assign(:post, create(:post, user: @current_user))
      expect(helper.contact_user_partial_path).to eq('shared/empty_partial')
    end

    it "returns login_required partial's path" do
      allow(helper).to receive(:user_signed_in?).and_return(false)
      expect(helper.contact_user_partial_path).to eq('posts/show/login_required')
    end
  end

  context "#leave_message_partial_path" do
    it "returns already_in_touch partial's path" do
      assign(:message_has_been_sent, true)
      expect(helper.leave_message_partial_path).to eq('posts/show/contact_user/already_in_touch')
    end

    it "returns message_form partial's path" do
      assign(:message_has_been_sent, false)
      expect(helper.leave_message_partial_path).to eq("posts/show/contact_user/message_form")
    end
  end
end

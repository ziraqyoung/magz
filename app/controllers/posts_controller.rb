class PostsController < ApplicationController
  include Pagy::Backend

  def show
    @post = Post.find(params[:id])
  end

  def hobby
    posts_for_branch(params[:action])
  end

  def study
    posts_for_branch(params[:action])
  end

  def team
    posts_for_branch(params[:action])
  end

  private

    def posts_for_branch(branch)
      @categories = Category.where(branch: branch)
      @pagy, @posts = pagy(get_posts)
    end

    def get_posts
      PostsForBranchService.new({
        search: params[:search],
        category: params[:category],
        branch: params[:action]
      }).call
    end
end

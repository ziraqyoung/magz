class PostsController < ApplicationController
  include Pagy::Backend

  before_action :redirect_if_not_signed_in, only: [:new]

  def new
    @branch = params[:branch]
    @categories = Category.where(branch: @branch)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to root_path
    end
  end

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

    def post_params
      params.require(:post).permit(:title, :content, :category_id).merge(user_id: current_user.id)
    end

    def get_posts
      PostsForBranchService.new({
                                  search: params[:search],
                                  category: params[:category],
                                  branch: params[:action]
                                }).call
    end
end

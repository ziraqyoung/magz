class Post < ApplicationRecord
  default_scope -> { includes(:user).order(created_at: :desc) }

  belongs_to :user
  belongs_to :category
end

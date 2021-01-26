class Post < ApplicationRecord
  default_scope -> { includes(:user).order(created_at: :desc) }
  scope :by_category, ->(branch, category_name) do
    joins(:category).where(categories: {name: category_name, branch: branch})
  end

  scope :by_branch, ->(branch) do
    joins(:category).where(categories: { branch: branch })
  end

  scope :search, ->(search_term) do
    where("title ILIKE lower(?) OR content ILIKE lower(?)", "%#{search_term}%", "%#{search_term}%")
  end

  belongs_to :user
  belongs_to :category
end

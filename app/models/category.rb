class Category < ActiveRecord::Base
  has_many :categories, through: :posts_categories
  has_many :posts_categories

  validates :name, presence: true
end
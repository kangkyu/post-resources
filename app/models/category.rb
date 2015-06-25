class Category < ActiveRecord::Base
  has_many :posts, through: :posts_categories
  has_many :posts_categories

  validates :name, presence: true, uniqueness: true

  def name=(val)
    write_attribute(:name, val.downcase)
  end
end

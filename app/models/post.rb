class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :posts_categories, dependent: :destroy
  has_many :categories, through: :posts_categories
  belongs_to :user

  validates :title, presence: true

  has_many :votes, as: :votable

  def hashtags
    self.description.split
    .select{|word| word != "#" && word.start_with?("#")}
    .map{|word| word.gsub!(/[[:punct:]]/, '')}
  end
end

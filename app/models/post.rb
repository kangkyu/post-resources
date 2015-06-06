class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :posts_categories, dependent: :destroy
  has_many :categories, through: :posts_categories
  belongs_to :user

  validates :title, presence: true

  has_many :votes, as: :votable

  def hashtag_words
    self.description.split
    .select{|word| word != "#" && word.start_with?("#")}
    .map{|word| word.gsub!(/[[:punct:]]/, '')}
  end

  # to_param :title
  # http://api.rubyonrails.org/classes/ActiveRecord/Integration/ClassMethods.html#method-i-to_param
  def to_param
    if (param = title.to_s.squish.truncate(20, separator: /\s/, omission: nil).parameterize).present?
      "#{id}-#{param}"
    else
      super()
    end
  end
end

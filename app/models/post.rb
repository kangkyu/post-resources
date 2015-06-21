class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :posts_categories, dependent: :destroy
  has_many :categories, through: :posts_categories
  belongs_to :user

  validates :title, presence: true

  include Votable

  def voted_by(user, voted)
    votes.find_or_initialize_by(user: user, votable_type: "Post")
        .update(voted: voted)
  end

  def hashtag_words
    self.description.split
    .select{|word| word != "#" && word.start_with?("#")}
    .map{|word| word.gsub!(/[[:punct:]]/, '')}
  end

  # to_param :title
  # http://api.rubyonrails.org/classes/ActiveRecord/Integration/ClassMethods.html#method-i-to_param
  def to_param
    if (param = title.to_s.squish.truncate(20, separator: /\s/, omission: nil).parameterize).present?
      param
    else
      super()
    end
  end

  def assign_categories
    id_array = self.category_ids
    self.hashtag_words.each do |word|
      word.downcase!
      id_array << Category.find_or_create_by(name: word).id
    end
    self.category_ids = id_array.uniq
  end
end

class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :posts_categories, dependent: :destroy
  has_many :categories, through: :posts_categories
  belongs_to :user

  validates :title, presence: true

  include Votable

  before_validation :scrub_url
  validates :url, uniqueness: true

  def hashtag_words
    self.description.scan(/#\w+/)
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

  def scrub_url
    return if url.nil?
    self.url = url.split('://').slice(1) if url.start_with?('http://', 'https://')
    self.url = url.split('.').slice(1..-1).join('.') if url.start_with?('www')
    self.url = url.chomp('/')
  end
end

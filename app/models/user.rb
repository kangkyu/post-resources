class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password

  validates :username, presence: true

  # users.yml
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # application_helper.rb
  def upvoted?(votable)
    (user_vote = votes.where(votable: votable).take) &&
      user_vote.voted == true
  end

  def downvoted?(votable)
    (user_vote = votes.where(votable: votable).take) &&
      user_vote.voted == false
  end

end

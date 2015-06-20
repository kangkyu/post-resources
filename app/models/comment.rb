class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :body, presence: true

  has_many :votes, as: :votable

  def net_votes
    votes.where(voted: true).count - votes.where(voted: false).count
  end

  def voted_by(user, voted)
    votes.find_or_initialize_by(user: user, votable_type: "Comment")
        .update(voted: voted)
  end
end

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :body, presence: true

  include Votable

  def voted_by(user, voted)
    votes.find_or_initialize_by(user: user, votable_type: "Comment")
        .update(voted: voted)
  end
end

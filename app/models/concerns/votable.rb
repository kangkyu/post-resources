module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def net_votes
    votes.where(voted: true).count - votes.where(voted: false).count
  end

  def voted_by(user, voted)
    votes.find_or_initialize_by(user: user, votable_type: self.class.to_s)
        .update(voted: voted)
  end
end

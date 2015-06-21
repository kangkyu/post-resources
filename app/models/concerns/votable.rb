module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def net_votes
    votes.where(voted: true).count - votes.where(voted: false).count
  end

end
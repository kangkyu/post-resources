module Votable

  def net_votes
    votes.where(voted: true).count - votes.where(voted: false).count
  end
  
end
module Votables

  def vote_votable(votable, voted)
    if !user_log_in?
      flash[:error] = "error. login needed to vote"
    else
      Vote.find_or_initialize_by(user_id: session[:user_id], votable_id: votable.id, votable_type: votable.class.to_s)
          .update(voted: voted)
    end
  end

end

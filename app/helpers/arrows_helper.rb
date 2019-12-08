module ArrowsHelper

  def vote_up_arrow(votable)

    voted_color =
      user_log_in? && user_upvoted?(votable) ? "OrangeRed" : "gray"

    link_to fa_icon("caret-up 2x", style: "color: #{voted_color};"),
      {
        voted: true,
        controller: votable.class.to_s.tableize,
        id: votable,
        action: 'vote'
      },
      method: 'post', class: "vote-up-post"
  end

  def vote_down_arrow(votable)

    voted_color =
      user_log_in? && user_downvoted?(votable) ? "OrangeRed" : "gray"

    link_to fa_icon("caret-down 2x", style: "color: #{voted_color};"),
      {
        voted: false,
        controller: votable.class.to_s.tableize,
        id: votable,
        action: 'vote'
      },
      method: 'post', class: "vote-down-post"
  end

  def user_upvoted?(votable)
    current_user.votes.where(votable: votable).take&.voted == true
  end

  def user_downvoted?(votable)
    current_user.votes.where(votable: votable).take&.voted == false
  end
end

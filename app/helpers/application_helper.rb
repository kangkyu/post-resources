module ApplicationHelper

  def external_url(url)
    if url.start_with?('http://', 'https://')
      url
    else
      "http://#{url}"
    end
  end

  def correct_user?(user)
    user_log_in? && current_user == user
  end

  def random_color
    ["Black", "Navy", "DarkBlue", "MediumBlue", "Blue", "DarkGreen", "Green", "Teal", "DarkCyan", "DeepSkyBlue", "DarkTurquoise", "MediumSpringGreen", "Lime", "SpringGreen", "Aqua", "Cyan", "MidnightBlue", "DodgerBlue", "LightSeaGreen", "ForestGreen", "SeaGreen", "DarkSlateGray", "LimeGreen", "MediumSeaGreen", "Turquoise", "RoyalBlue", "SteelBlue", "DarkSlateBlue", "MediumTurquoise", "Indigo", "DarkOliveGreen", "CadetBlue", "CornflowerBlue", "RebeccaPurple", "MediumAquaMarine", "DimGray", "SlateBlue", "OliveDrab", "SlateGray", "LightSlateGray", "MediumSlateBlue", "LawnGreen", "Chartreuse", "Aquamarine", "Maroon", "Purple", "Olive", "Gray", "SkyBlue", "LightSkyBlue", "BlueViolet", "DarkRed", "DarkMagenta", "SaddleBrown", "DarkSeaGreen", "LightGreen", "MediumPurple", "DarkViolet", "PaleGreen", "DarkOrchid", "YellowGreen", "Sienna", "Brown", "DarkGray", "LightBlue", "GreenYellow", "PaleTurquoise", "LightSteelBlue", "PowderBlue", "FireBrick", "DarkGoldenRod", "MediumOrchid", "RosyBrown", "DarkKhaki", "Silver", "MediumVioletRed", "IndianRed", "Peru", "Chocolate", "Tan", "LightGray", "Thistle", "Orchid", "GoldenRod", "PaleVioletRed", "Crimson", "Gainsboro", "Plum", "BurlyWood", "LightCyan", "Lavender", "DarkSalmon", "Violet", "PaleGoldenRod", "LightCoral", "Khaki", "AliceBlue", "HoneyDew", "Azure", "SandyBrown", "Wheat", "Beige", "WhiteSmoke", "MintCream", "GhostWhite", "Salmon", "AntiqueWhite", "Linen", "LightGoldenRodYellow", "OldLace", "Red", "Fuchsia", "Magenta", "DeepPink", "OrangeRed", "Tomato", "HotPink", "Coral", "DarkOrange", "LightSalmon", "Orange", "LightPink", "Pink", "Gold", "PeachPuff", "NavajoWhite", "Moccasin", "Bisque", "MistyRose", "BlanchedAlmond", "PapayaWhip", "LavenderBlush", "SeaShell", "Cornsilk", "LemonChiffon", "FloralWhite", "Snow", "Yellow", "LightYellow", "Ivory", "White"].sample
  end

  def caret_vote_icon(votable, direction = :up)
    is_up = direction == :up || direction != :down
    # if current_user already voted to this votable, color up-arrow or down-arrow for which direction voted to.
    if current_user &&
        votable.votes.where(user: current_user).take &&
          votable.votes.where(user: current_user).take.voted == is_up
      # link_to({controller: votable.class.to_s.downcase.pluralize, id: votable, voted: nil, action: 'vote'}, method: 'post', remote: true, class: (is_up && votable.is_a?(Post) ? "vote-up-post" : "vote-down-post")) do
      #   (is_up && votable.is_a?(Post) ? "up" : "down")
      # end
      link_to fa_icon((is_up ? "caret-up 2x" : "caret-down 2x"), style: "color: OrangeRed;"), {controller: votable.class.to_s.downcase.pluralize, id: votable, voted: nil, action: 'vote'}, method: 'post'
    else
      # link_to({controller: votable.class.to_s.downcase.pluralize, id: votable, voted: is_up, action: 'vote'}, method: 'post', remote: true) do
      #   (is_up && votable.is_a?(Post) ? "up" : "down")
      # end
      link_to fa_icon((is_up ? "caret-up 2x" : "caret-down 2x"), style: "color: gray;"), {controller: votable.class.to_s.downcase.pluralize, id: votable, voted: is_up, action: 'vote'}, method: 'post'
    end
  end
end

module PostsHelper
  def description_format text
    text.gsub!(/#\w+/) do |hashtag|
      if category = Category.find_by(name: hashtag[1..-1].downcase)
        link_to hashtag, category
      else
        hashtag
      end
    end
    simple_format text
  end
end

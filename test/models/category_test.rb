require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  def test_save_category_name
    category = Category.new(name: "Ruby")
    assert category.save
    assert_equal "ruby", category.name
  end
end

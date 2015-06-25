require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  test "save category name" do
    category = Category.new(name: "Ruby")
    assert category.save
    assert_equal "ruby", category.name
  end
end

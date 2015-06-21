require 'test_helper'

class VotePostsTest < Capybara::Rails::TestCase
  test "vote at posts show page" do
    skip
    visit login_path
    fill_in "Username", with: users(:one).username
    fill_in "Password", with: 'password'
    click_button "Login"

    post = posts(:one)
    visit post_path(post)
    assert_link 'up'
    # assert_link find('.vote-up-post')
    # click_link find('.vote-up-post')

    # save_and_open_page
    click_link 'up'
    assert_text "1"

    click_link 'down'
    assert_text "-1"
  end
end
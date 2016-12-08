require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  test 'tweet has to belong to someone' do
    tweet = Tweet.new(content: "somethingrandom")

    assert_not tweet.save
  end

  test 'tweet should not be empty' do
    tweet = Tweet.new(user: users(:a))

    assert_not tweet.save
  end

  test 'tweet by user with content should be valid' do
    tweet = tweets(:one)

    assert tweet.valid?
  end
end

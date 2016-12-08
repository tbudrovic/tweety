require 'test_helper'

class TweetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tweet = tweets(:one)
    @encoded_credentials = 
      ActionController::HttpAuthentication::Basic.encode_credentials(users(:firstuser).name,
                                                                     'secretpass')
  end

  test "should get index" do
    get tweets_url, as: :json
    assert_response :success
  end

  test "should get all users' tweets when called nested" do
    get user_tweets_url(users(:firstuser)), as: :json

    assert_response :success

    tweets = JSON.parse(response.body)
    assert_equal tweets.count, 2
    assert_equal tweets[0]['id'], @tweet.id
    assert_equal tweets[0]['content'], @tweet.content
  end

  test "authorized user should be able to create tweet" do
    assert_difference('Tweet.count') do
      post tweets_url,
           params: { content: tweets(:two).content },
           headers: { 'HTTP_AUTHORIZATION': @encoded_credentials },
           as: :json
    end

    assert_response 201
  end

  test "should show tweet" do
    get tweet_url(@tweet), as: :json
    assert_response :success
  end

  test "authorized user should be able to update tweet" do
    patch tweet_url(@tweet),
          params: { content: tweets(:two) },
          headers: { 'HTTP_AUTHORIZATION': @encoded_credentials },
          as: :json

    assert_response 200
  end

  test "authorized user should be able to destroy tweet" do
    assert_difference('Tweet.count', -1) do
      delete tweet_url(@tweet),
             headers: { 'HTTP_AUTHORIZATION': @encoded_credentials },
             as: :json
    end

    assert_response 204
  end

  test "unauthorized user should not be able to create tweet" do
    assert_difference('Tweet.count', 0) do
      post tweets_url, params: { content: tweets(:one) }, as: :json
    end

    assert_response :unauthorized
  end

  test "unauthorized user should not be able to modify tweet" do
    patch tweet_url(@tweet), as: :json

    assert_response :unauthorized
  end

  test "unauthorized user should not be able to delete tweet" do
    delete tweet_url(@tweet), as: :json

    assert_response :unauthorized
  end
end

require "test_helper"

class ChatAiControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chat_ai_index_url
    assert_response :success
  end

  test "should get ask" do
    get chat_ai_ask_url
    assert_response :success
  end
end

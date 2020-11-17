require 'test_helper'

class SuportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @suport = suports(:one)
  end

  test "should get index" do
    get suports_url
    assert_response :success
  end

  test "should get new" do
    get new_suport_url
    assert_response :success
  end

  test "should create suport" do
    assert_difference('Suport.count') do
      post suports_url, params: { suport: { email: @suport.email, message: @suport.message, name: @suport.name, owner_id: @suport.owner_id, subject: @suport.subject, user_id: @suport.user_id } }
    end

    assert_redirected_to suport_url(Suport.last)
  end

  test "should show suport" do
    get suport_url(@suport)
    assert_response :success
  end

  test "should get edit" do
    get edit_suport_url(@suport)
    assert_response :success
  end

  test "should update suport" do
    patch suport_url(@suport), params: { suport: { email: @suport.email, message: @suport.message, name: @suport.name, owner_id: @suport.owner_id, subject: @suport.subject, user_id: @suport.user_id } }
    assert_redirected_to suport_url(@suport)
  end

  test "should destroy suport" do
    assert_difference('Suport.count', -1) do
      delete suport_url(@suport)
    end

    assert_redirected_to suports_url
  end
end

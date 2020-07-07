require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test 'create should fail without name' do
    post api_feedbacks_path, params: { comment: 'blah' }
    assert_response :bad_request
    assert_equal 'param is missing or the value is empty: name'.to_json, @response.body
  end

  test 'create should fail without comment' do
    post api_feedbacks_path, params: { name: 'blah' }
    assert_response :bad_request
    assert_equal 'param is missing or the value is empty: comment'.to_json, @response.body
  end

  test 'create should fail when name is < 2 chars' do
    post api_feedbacks_path, params: { name: 'n', comment: 'blah' }
    assert_response :bad_request
    error_response = { name: ['must have at least 2 characters'] }
    assert_equal error_response.to_json, @response.body
  end

  test 'create should fail when comment is < 2 chars' do
    post api_feedbacks_path, params: { name: 'blah', comment: 'c' }
    assert_response :bad_request
    error_response = { comment: ['must have at least 2 characters'] }
    assert_equal error_response.to_json, @response.body
  end

  test 'create succeeds with valid params' do
    post api_feedbacks_path, params: { name: 'name', comment: 'comment' }
    assert_response :success
    assert_empty @response.body
  end
end

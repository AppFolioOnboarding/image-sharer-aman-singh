require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase
  test 'should succeed for valid name and comment' do
    feedback = Feedback.new name: 'batman', comment: 'Please delete my pics without mask'
    assert feedback.valid?
  end

  test 'should fail for name < 2 characters' do
    feedback = Feedback.new name: 'b', comment: 'blah'
    assert_not feedback.valid?
  end

  test 'should fail for comment < 2 characters' do
    feedback = Feedback.new name: 'hulk', comment: 'h'
    assert_not feedback.valid?
  end

  test 'should fail for name > 50 characters' do
    feedback = Feedback.new name: 'a' * 51, comment: 'blah'
    assert_not feedback.valid?
  end

  test 'should fail for comment > 500 characters' do
    feedback = Feedback.new name: 'hodor', comment: 'hodor' * 101
    assert_not feedback.valid?
  end
end

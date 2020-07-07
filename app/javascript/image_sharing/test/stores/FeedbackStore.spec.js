import { expect } from 'chai';
import { describe, it, beforeEach } from 'mocha';
import sinon from 'sinon';
import FeedbackStore from '../../stores/FeedbackStore';
import PostFeedbackService from '../../services/PostFeedbackService';

describe('FeedbackStore', () => {
  const store = new FeedbackStore();

  beforeEach(() => {
    sinon.restore();
  });

  it('should store values for name and comment', () => {
    store.setComment('blah blah');
    store.setName('appfolio');
    expect(store.comment).to.eq('blah blah');
    expect(store.name).to.eq('appfolio');
  });

  it('should add feedback and update alert to success when onSubmit is called', () => {
    const addFeedback = sinon.stub(PostFeedbackService, 'addFeedback')
      .callsFake(() => Promise.resolve());
    store.setComment('blah blah');
    store.setName('appfolio');
    store.onSubmit().then(() => {
      expect(store.alert.level).to.eq('success');
      expect(store.alert.message).to.eq('Feedback submitted!');
    });
    expect(addFeedback).to.have.property('callCount', 1);
    sinon.assert.calledWith(addFeedback, store.name, store.comment);
  });

  it('should call add feedback and update alert to danger when addFeedback call fails', () => {
    const addFeedback = sinon.stub(PostFeedbackService, 'addFeedback')
      .callsFake(() => Promise.reject());
    store.onSubmit().then(() => {
      expect(store.alert.level).to.eq('danger');
      expect(store.alert.message).to.eq('Error submitting feedback, please try later.');
    });
    expect(addFeedback).to.have.property('callCount', 1);
  });
});

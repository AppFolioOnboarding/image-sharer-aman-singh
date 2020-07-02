import { expect } from 'chai';
import { describe, it } from 'mocha';
import FeedbackStore from '../../stores/FeedbackStore';

describe('FeedbackStore', () => {
  it('should store values for name and comment', () => {
    const store = new FeedbackStore();
    store.setComment('blah blah');
    store.setName('appfolio');
    expect(store.comment).to.eq('blah blah');
    expect(store.name).to.eq('appfolio');
  });
});

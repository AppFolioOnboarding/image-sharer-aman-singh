import { expect } from 'chai';
import { describe, it, beforeEach } from 'mocha';
import sinon from 'sinon';
import PostFeedbackService from '../../services/PostFeedbackService';
import * as helper from '../../utils/helper';

describe('PostFeedbackService', () => {
  let post = null;
  beforeEach(() => {
    sinon.restore();
    post = sinon.stub(helper, 'post');
  });

  it('should return post feedbacks success response', () => {
    const exp = 'success';
    post.callsFake(() => Promise.resolve(exp));
    PostFeedbackService.addFeedback('feed', 'back').then((res) => {
      expect(res).to.eq(exp);
    });
  });

  it('should return post feedbacks failure response', () => {
    const exp = 'failure';
    post.callsFake(() => Promise.reject(exp));
    PostFeedbackService.addFeedback('feed', 'back').catch((res) => {
      expect(res).to.eq(exp);
    });
  });
});

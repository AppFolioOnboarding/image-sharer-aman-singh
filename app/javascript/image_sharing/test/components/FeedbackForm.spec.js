import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import FeedbackForm from '../../components/FeedbackForm';
import FeedbackStore from '../../stores/FeedbackStore';

const stores = {
  feedbackStore: new FeedbackStore()
};

describe('<FeedbackForm />', () => {
  const wrapper = shallow(<FeedbackForm.wrappedComponent stores={stores} />);

  it('should have input field for name', () => {
    const nameInput = wrapper.find('input');
    expect(nameInput).to.have.lengthOf(1);
    expect(nameInput.prop('className')).to.eq('form-control');
    expect(nameInput.prop('type')).to.eq('text');
    expect(wrapper.find('#name')).to.have.lengthOf(1);
  });

  it('should have input field for comments', () => {
    const commentArea = wrapper.find('textarea');
    expect(commentArea).to.have.lengthOf(1);
    expect(commentArea.prop('className')).to.eq('form-control');
    expect(wrapper.find('#comment')).to.have.lengthOf(1);
  });

  it('should update store when name is added', () => {
    const nameInput = wrapper.find('input');
    nameInput.simulate('change', { target: { value: 'appfolio' } });
    expect(stores.feedbackStore.name).to.eq('appfolio');
  });

  it('should update store when comment is added', () => {
    const nameInput = wrapper.find('textarea');
    nameInput.simulate('change', { target: { value: 'blah blah blah' } });
    expect(stores.feedbackStore.comment).to.eq('blah blah blah');
  });
});

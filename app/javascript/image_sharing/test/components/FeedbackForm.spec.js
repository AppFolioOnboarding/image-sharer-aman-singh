import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import sinon from 'sinon';
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
    expect(nameInput.prop('required')).to.eq(true);
    expect(wrapper.find('#name')).to.have.lengthOf(1);
  });

  it('should have input field for comments', () => {
    const commentArea = wrapper.find('textarea');
    expect(commentArea).to.have.lengthOf(1);
    expect(commentArea.prop('className')).to.eq('form-control');
    expect(commentArea.prop('required')).to.eq(true);
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

  it('should have an alert', () => {
    const alert = wrapper.find('Alert');
    expect(alert).to.have.lengthOf(1);
  });

  it('should call onSubmit() when form submitted', () => {
    const localWrapper = shallow(<FeedbackForm.wrappedComponent stores={stores} />);
    const component = localWrapper.instance();
    const onSubmitStub = sinon.stub(component, 'onSubmit');

    component.forceUpdate();
    localWrapper.update();

    localWrapper.find('form').simulate('submit');
    expect(onSubmitStub).to.have.property('callCount', 1);
  });

  it('should prevent default behavior and call store.onSubmit() when onSubmit() is called', () => {
    const localStores = {
      feedbackStore: new FeedbackStore()
    };
    const onSubmit = sinon.stub(localStores.feedbackStore, 'onSubmit');
    const localWrapper = shallow(<FeedbackForm.wrappedComponent stores={localStores} />);
    const component = localWrapper.instance();
    const clickEvent = new Event('click');
    const preventDefault = sinon.stub(clickEvent, 'preventDefault');
    component.onSubmit(clickEvent);

    expect(preventDefault).to.have.property('callCount', 1);
    expect(onSubmit).to.have.property('callCount', 1);
  });
});

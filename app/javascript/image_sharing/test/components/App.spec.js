import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import App from '../../components/App';
import Footer from '../../components/Footer';
import Header from '../../components/Header';
import FeedbackForm from '../../components/FeedbackForm';

const stores = {
  feedbackStore: {}
};

describe('<App />', () => {
  const wrapper = shallow(<App.wrappedComponent stores={stores} />);

  it('should have a header with title', () => {
    expect(wrapper.find(Header)).to.have.lengthOf(1);
    expect(wrapper.find(Header).prop('title')).to.equal('Tell us what you think');
  });

  it('should have a footer', () => {
    expect(wrapper.find(Footer)).to.have.lengthOf(1);
  });

  it('should have a FeedbackForm', () => {
    expect(wrapper.find(FeedbackForm)).to.have.lengthOf(1);
  });
});

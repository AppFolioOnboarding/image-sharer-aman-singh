import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import App from '../../components/App';

const stores = {
  feedbackStore: {}
};

describe('<App />', () => {
  const wrapper = shallow(<App.wrappedComponent stores={stores} />);

  it('should have a header with title', () => {
    expect(wrapper.find('Header')).to.have.lengthOf(1);
    expect(wrapper.find('Header').prop('title')).to.equal('Tell us what you think');
  });

  it('should have a footer', () => {
    expect(wrapper.find('Footer')).to.have.lengthOf(1);
  });
});

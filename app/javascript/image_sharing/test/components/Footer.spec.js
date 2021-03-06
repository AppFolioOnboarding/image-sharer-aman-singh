import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import Footer from '../../components/Footer';

describe('<Footer />', () => {
  const wrapper = shallow(<Footer />);

  it('should have a p tag', () => {
    expect(wrapper.find('p')).to.have.lengthOf(1);
  });

  it('should display Copyright message', () => {
    expect(wrapper.find('.footer').text()).to.equal('Copyright: AppFolio Inc. Onboarding');
  });
});

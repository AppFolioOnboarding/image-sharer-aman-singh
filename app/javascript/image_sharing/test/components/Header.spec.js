import React from 'react';
import { shallow } from 'enzyme';
import { expect } from 'chai';
import { describe, it } from 'mocha';
import Header from '../../components/Header';

describe('<Header />', () => {
  const wrapper = shallow(<Header title='Tell us what you think' />);

  it('should have a h3 tag', () => {
    expect(wrapper.find('h3')).to.have.lengthOf(1);
  });

  it('should display feedback title', () => {
    expect(wrapper.find('h3').text()).to.equal('Tell us what you think');
  });
});

require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'should fail on invalid image url' do
    image = Image.new url: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.pdf'
    assert_not image.valid?
  end

  test 'should succeed for a valid image url' do
    image = Image.new url: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg'
    assert image.valid?
  end
end

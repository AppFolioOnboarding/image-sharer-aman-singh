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

  test 'should be able to add tags' do
    image = Image.new url: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg',
                      tag_list: 'tag1, tag2'
    assert image.valid?
    assert_equal 'tag1', image.tag_list[0]
    assert_equal 'tag2', image.tag_list[1]
  end

  test 'should not have tags if not added' do
    image = Image.new url: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg'
    assert image.valid?
    assert_empty image.tag_list
  end
end

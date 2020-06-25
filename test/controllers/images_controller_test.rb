require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_image_path
    assert_response :success
    assert_select '#new-form'
  end

  test 'should render new for invalid urls' do
    post images_path, params: { image: { url: 'invalid' } }
    assert_response :success
    assert_select '#invalid-image-label'
  end

  test 'should redirect to show for valid image url' do
    assert_difference 'Image.count', 1 do
      post images_path, params:
        { image: { url: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg' } }
    end
    assert_redirected_to image_path(Image.last.id)
    follow_redirect!
    assert_response :success
    assert_select '.flash-message-div'
  end

  test 'should display uploaded image after image creation' do
    image = Image.create! url: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg'
    get image_path(image.id)
    assert_response :success
    assert_select '#show-image'
  end

  test 'should accept tags for create request' do
    post images_path, params:
      { image: { url: 'https://cdn.pixabay.com/736885_960_720.jpg', tag_list: 'tag1' } }
    assert_equal 'tag1', Image.first.tag_list[0]
  end

  test 'should fail if tag query param missing for index api call' do
    assert_raises(ActionController::ParameterMissing) do
      get images_path
    end
  end

  test 'should only display images for a given tag' do
    Image.create! url: 'https://cdn.pixabay.com/1.jpg', tag_list: 'tag1'
    Image.create! url: 'https://cdn.pixabay.com/1.jpg', tag_list: 'tag1, tag2, tag3'
    Image.create! url: 'https://cdn.pixabay.com/2.jpg', tag_list: 'tag2'
    Image.create! url: 'https://cdn.pixabay.com/3.jpg', tag_list: 'tag2, tag3, tag4'
    get images_path, params: { tag: :tag1 }
    assert_response :success
    assert_select '.index-img', 2 do |elements|
      assert_equal 'https://cdn.pixabay.com/1.jpg', elements[0].attributes['src'].value
    end
  end

  test 'should display no images if tag isn\'t found' do
    Image.create! url: 'https://cdn.pixabay.com/1.jpg', tag_list: 'blah'
    get images_path, params: { tag: :tag1 }
    assert_response :success
    assert_select '.index-img', 0
  end
end

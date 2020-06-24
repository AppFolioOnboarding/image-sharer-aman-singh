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
end

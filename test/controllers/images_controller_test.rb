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

  test 'should get images#index at root path' do
    get root_path
    assert_response :success
    assert_select '#title', "Welcome to Aman's Image Sharer"
  end

  test 'should display all previously uploaded images when tag isn\'t provided' do
    Image.create!(url: 'https://appf.com/1.jpg', created_at: Time.zone.today - 1.day)
    Image.create!(url: 'https://appf.com/2.jpg', created_at: Time.zone.today)
    Image.create!(url: 'https://appf.com/3.jpg', created_at: Time.zone.today - 2.days)
    count = Image.all.count
    get root_path
    assert_response :success
    assert_select 'img', count do |elements|
      assert_equal('https://appf.com/2.jpg', elements[0].attributes['src'].value)
      assert_equal('https://appf.com/1.jpg', elements[1].attributes['src'].value)
      assert_equal('https://appf.com/3.jpg', elements[2].attributes['src'].value)
    end
  end

  test 'should delete image and redirect to home page' do
    Image.create! url: 'https://cdn.pixabay.com/1.jpg'
    image = Image.create! url: 'https://cdn.pixabay.com/736885_960_720.jpg'
    assert_difference 'Image.count', -1 do
      delete image_path(image.id)
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_select '.flash-message-div'
    assert_select '.index-img', 1
  end

  test 'should redirect to home page if image id not found' do
    Image.create! url: 'https://cdn.pixabay.com/1.jpg'
    assert_difference 'Image.count', 0 do
      delete image_path(10)
    end
    assert_redirected_to root_path
  end

  test 'should redirect to home page if image id is string' do
    delete image_path('kjsd')
    assert_redirected_to root_path
  end
  # Other test case that I'm not adding because it needs more input validation than seems necessary for a test
  # app - testing for integer id that will overflow the Integer datatype being used
end

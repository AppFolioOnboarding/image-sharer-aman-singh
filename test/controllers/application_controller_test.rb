require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get root_path
    assert_response :success
    assert_select '#title', "Welcome to Aman's image sharer app"
  end

  test 'should display all previously uploaded images' do
    Image.create!(url: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/1.jpg', created_at: Date.today - 1.day)
    Image.create!(url: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/2.jpg', created_at: Date.today)
    Image.create!(url: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/3.jpg', created_at: Date.today - 2.days)
    count = Image.all.count
    get root_path
    assert_response :success
    assert_select 'img', count do |elements|
      assert_equal('https://cdn.pixabay.com/photo/2015/04/23/22/00/2.jpg', elements[0].attributes['src'].value)
      assert_equal('https://cdn.pixabay.com/photo/2015/04/23/22/00/1.jpg', elements[1].attributes['src'].value)
      assert_equal('https://cdn.pixabay.com/photo/2015/04/23/22/00/3.jpg', elements[2].attributes['src'].value)
    end
  end
end

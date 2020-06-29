require File.dirname(__FILE__) + '/image_card'

module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :images

      collection :images, locator: '#index-images', item_locator: '.index-img-card', contains: ImageCard do
        def view!
          node.find('.index-img-show').click
          window.change_to(ShowPage)
        end
      end

      def add_new_image!
        node.click_on('New Image')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        target = images.select { |image| image.url == url && (tags.nil? || image.tags == tags) }
        !target.empty?
      end

      def clear_tag_filter!
        # TODO
      end
    end
  end
end

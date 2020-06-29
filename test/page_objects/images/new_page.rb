module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_image

      form_for :image do
        element :url, locator: 'new-image-url'
      end

      def create_image!(url: nil, tags: nil)
        # TODO
      end
    end
  end
end

module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      def url
        node.find('img')[:src]
      end

      def tags
        node.all('.index-img-tag').map(&:text).join(',')
      end

      def click_tag!(tag_name)
        # TODO
      end
    end
  end
end

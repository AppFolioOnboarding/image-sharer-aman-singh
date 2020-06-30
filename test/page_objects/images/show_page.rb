module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      def image_url
        # TODO
      end

      def tags
        # TODO
      end

      def delete
        node.find('.show-delete-img').click
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!
        node.find('.show-delete-img').click
        node.driver.browser.switch_to.alert.accept
        window.change_to(IndexPage)
      end

      def go_back_to_index!
        # TODO
      end
    end
  end
end

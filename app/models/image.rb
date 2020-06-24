class Image < ApplicationRecord
  acts_as_taggable_on :tags
  url_regex = %r{(https?:\/\/.*\.(?:png|jpg|gif|tif|jpeg))}

  validates :url, format: { with: url_regex, message: 'invalid image url' }
end

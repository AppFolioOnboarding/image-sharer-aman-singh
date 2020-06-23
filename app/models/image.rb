class Image < ApplicationRecord
  url_regex = %r{(https?:\/\/.*\.(?:png|jpg|gif|tif|jpeg))}

  validates :url, format: { with: url_regex, message: 'invalid image url' }
end

class PostBand < ApplicationRecord
  belongs_to :post
  belongs_to :band
end

class Item < ActiveRecord::Base
  belongs_to :bucketlist
  enum status: [ :not_done, :done ]
end

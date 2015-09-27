class Item < ActiveRecord::Base
  belongs_to :bucketlist
  enum status: [ :not_done, :done ]
  validates :name, presence: true
  validates :status, presence: true, inclusion: {in: statuses }
  validates :bucketlist, presence: true
end

class Bucketlist < ActiveRecord::Base
  has_many :items
  belongs_to :user

  validates :name, presence: true
  # validates :user, presence: true
end

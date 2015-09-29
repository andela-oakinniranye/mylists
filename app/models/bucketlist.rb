class Bucketlist < ActiveRecord::Base
  scope :random, -> { limit(1).offset(rand(count)).first }
  has_many :items, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
  validates :user, presence: true

  def self.fetch_bucketlists_with_items
    includes(:items)
  end
end

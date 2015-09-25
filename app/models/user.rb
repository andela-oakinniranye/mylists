class User < ActiveRecord::Base
  has_many :bucketlists
  before_create :add_unique_token

  private
    def add_unique_token
      begin
        token = generate_token
        self.token = token
      end while User.find_by_token(token)
    end

    def generate_token
      SecureRandom.uuid.gsub(/\-/, '')
    end
end

RSpec.configure do |config|
  config.before do
    load 'db/seeds.rb'
  end
end

module Authorization
  def make_request(type, path, options=nil, auth_token={})
    auth = auth_token.blank? ? {} : {authorization: "Token token=#{auth_token}"}
    self.send(type, path, options, auth)
  end
end

module JsonHelpers
  def json
    @json ||= JSON.parse(response.body)
  end
end


RSpec.configure do |config|
  config.include Authorization, type: :request
  config.include JsonHelpers, type: :request
end

# {authorization: "Token token=#{auth_token}"}

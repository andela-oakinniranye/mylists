json.array!(@bucketlists) do |bucketlist|
  json.extract! bucketlist, :id, :name
  # json.url api_v1_bucketlist_url(bucketlist, format: :json)
end

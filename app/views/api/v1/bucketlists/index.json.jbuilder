json.array!(@bucketlists) do |bucketlist|
  json.extract! bucketlist, :id, :name
end

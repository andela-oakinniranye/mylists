json.extract! @bucketlist, :id, :name
json.items @bucketlist.items do |item|
  json.extract! item, :id, :name
  json.date_created format_date(item.created_at)
  json.date_modified format_date(item.updated_at)
  json.done item.done?.to_s.capitalize
end
json.date_created format_date(@bucketlist.created_at)
json.date_modified format_date(@bucketlist.updated_at)
json.created_by @bucketlist.user_id

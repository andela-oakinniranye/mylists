class BucketlistSerializer < ActiveModel::Serializer
  # include DateManipulation
  #, :items, :date_created, :date_modified, :created_by
  attributes :id, :name
end

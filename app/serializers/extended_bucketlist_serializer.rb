class ExtendedBucketlistSerializer < BucketlistSerializer
  has_many :items
  attributes :items, :date_created, :date_modified, :created_by

  def created_by
    object.user
  end

  def date_created
    object.created_at.strftime("%F %T")
  end

  def date_modified
    object.updated_at.strftime("%F %T")
  end
end

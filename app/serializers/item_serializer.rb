class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :date_created, :date_modified, :done

  def date_created
    object.created_at.strftime("%F %T")
  end

  def date_modified
    object.updated_at.strftime("%F %T")
  end

  def done
    object.done?.to_s.capitalize
  end
end

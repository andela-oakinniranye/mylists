module DateManipulation
  def date_created
    object.created_at.strftime("%F %T")
  end

  def date_modified
    object.updated_at.strftime("%F %T")
  end
end

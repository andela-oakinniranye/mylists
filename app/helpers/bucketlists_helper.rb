module BucketlistsHelper
  def format_date(date)
    date.strftime("%F %T")
  end
end

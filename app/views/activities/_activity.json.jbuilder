json.extract! activity, :id, :name, :descr, :image, :created_at, :updated_at
json.url activity_url(activity, format: :json)

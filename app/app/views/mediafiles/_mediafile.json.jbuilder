json.extract! mediafile, :id, :references, :name, :created_at, :updated_at
json.url mediafile_url(mediafile, format: :json)

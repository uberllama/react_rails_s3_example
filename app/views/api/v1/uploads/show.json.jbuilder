json.upload do
  json.extract!(@generate_upload_url_service, :url, :content_type)
end

json.extract!(document, :id, :upload_file_name, :upload_content_type, :upload_file_size, :status, :created_at)
json.url document.upload.url

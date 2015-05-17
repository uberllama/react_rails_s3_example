class Api::V1::DocumentsController < ApplicationController

  def index
    @documents = Document.all
  end

  def create
    @create_document_service = CreateDocument.new(document_params)
    @document = @create_document_service.document
    if @create_document_service.call
      render :show, status: :created
    else
      render json: { errors: @document.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def document_params
    params.require(:document).permit(:direct_upload_url, :upload_content_type, :upload_file_name, :upload_file_size)
  end

end

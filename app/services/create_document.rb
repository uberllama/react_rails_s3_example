# Handles async Document create and processing workflow
class CreateDocument

  attr_reader :current_user, :params, :document

  # @example
  #   create_document_service = CreateDocument.new(create_params)
  #   create_document_service.call
  #
  # @param params [Hash]
  def initialize(params)
    @params = params
    build
  end

  # @return [Boolean] Document saved
  def call
    saved = @document.save
    if saved
      queue_process
    end
    saved
  end

  private

  def build
    @document = Document.new(@params)
  end

  def queue_process
    ProcessDocumentJob.perform_later(@document)
  end

end

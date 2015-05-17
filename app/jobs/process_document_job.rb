# Final upload processing step:
#
# 1) Set upload source to direct_upload_url, which instantiates download, process, re-upload to final path
# 2) Set status to processed
#
# @note Temporary uploads in /uploads are purged by AWS S3 Lifecycle cleaning.
# @see http://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html
# @see http://docs.aws.amazon.com/AmazonS3/latest/dev/CopyingObjectUsingRuby.html
#
# @note Bang required to cancel save on content type spoof
class ProcessDocumentJob < ActiveJob::Base
  queue_as :default

  def perform(document)
    document.upload = URI.parse(document.direct_upload_url)
    document.status = "processed"
    document.save!
  end

end

# == Schema Information
#
# Table name: documents
#
#  id                  :integer          not null, primary key
#  direct_upload_url   :string           not null
#  upload_file_name    :string
#  upload_content_type :string
#  upload_file_size    :integer
#  upload_updated_at   :datetime
#  status              :integer          default(0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_documents_on_status  (status)
#

class Document < ActiveRecord::Base

  # Direct upload url verifier validates whitelisted direct upload source
  #
  # @note CORS required on s3 buckets to facilitate direct upload
 #
  # @example Valid URL
  #   "https://babysloths.s3.amazonaws.com/uploads/23c887f6-02e0-40f3-a31d-c487124fa5d3/eating_a_carrot.pdf"
  #
  # @example Invalid URL
  #   "http://somewhereelse.com/malware.exe"
  #
  DIRECT_UPLOAD_URL_FORMAT = %r{
    \A
    https:\/\/
    #{Rails.application.secrets.aws['s3_bucket_name']}\.s3\.amazonaws\.com\/
    (?<path>uploads\/.+\/(?<filename>.+))
    \z
  }x.freeze

  enum status: { unprocessed: 0, processed: 1 }

  has_attached_file :upload

  validates :direct_upload_url, presence: true, format: { with: DIRECT_UPLOAD_URL_FORMAT }
  do_not_validate_attachment_file_type :upload

end

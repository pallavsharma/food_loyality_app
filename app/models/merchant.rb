class Merchant < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :businessname, presence: true, length: { maximum: 50 }
  validates :qr_code_url, url: true, allow_blank: true
  validates :image_url, url: true, allow_blank: true
  validates :video_url, url: true, allow_blank: true
  validates :address, presence: true, length: { maximum: 255 }
  validates :location, presence: true
  validates :metadata, presence: true
  validate :metadata_is_json

  def generate_qr_code
    self.qr_code_url = QrCodeGenerator.generate(self.id) # example class to generate qr code.
    save
  end

  def self.search(query)
    where("businessname ILIKE ? OR username ILIKE ?", "%#{query}%", "%#{query}%")
  end

  def parsed_metadata
    JSON.parse(self.metadata)
  end

  private

  def metadata_is_json
    JSON.parse(metadata) if metadata.present?
  rescue JSON::ParserError
    errors.add(:metadata, "must be a valid JSON object")
  end
end

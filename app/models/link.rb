class Link < ApplicationRecord
  validates :bezeichner, presence: true, length: { maximum: 255 }
  validate :acceptable_image

  has_one_attached :header_image

  scope :online, -> { where(online: true) }
  scope :sortiert, -> { order(:position) }

  # Hilfsmethoden
  def status_text
    online? ? "Online" : "Offline"
  end

  def has_header_image?
    header_image.attached?
  end

  private

  def acceptable_image
    return unless header_image.attached?

    unless header_image.blob.byte_size <= 5.megabyte
      errors.add(:header_image, "ist zu groß (max. 5MB)")
    end

    acceptable_types = %w[image/jpeg image/jpg image/png image/gif]
    unless acceptable_types.include?(header_image.blob.content_type)
      errors.add(:header_image, "muss ein Bild sein (JPG, PNG, GIF)")
    end
  end
end

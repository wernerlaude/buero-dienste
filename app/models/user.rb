class User < ApplicationRecord
  include Visitable

  before_create :generate_otp_secret

  belongs_to :bundesland
  has_and_belongs_to_many :offers
  has_many :blog_posts
  has_many :access_tokens, dependent: :destroy

  has_rich_text :beschreibung

  has_one_attached :header_image do |attachable|
    attachable.variant :medium, resize_to_limit: [ 330, 330 ]
  end

  has_many_attached :uploads do |attachable|
    attachable.variant :medium, resize_to_limit: [ 330, 330 ]
  end

  geocoded_by :fulladdress

  scope :premium, -> { where(premium: true) }
  scope :standard, -> { where(premium: false) }
  scope :online, -> { where(online: true) }
  scope :sortiert, -> { order(:nachname) }
  scope :ort, -> { order(:ort) }
  scope :plz, -> { order(:plz) }
  scope :maps, -> { where(maps: true) }
  scope :visible, -> { where(visible: true) }

  def premium?
    self.premium
  end

  def ort_plz
    [ plz, ort ].compact.join(" ")
  end

  def for_cano
    [ vorname, nachname, ort ].join("-")
  end

  def fullname
    [ vorname, nachname ].join(" ")
  end

  def fulladdress
    [ strasse, plz, ort, "Deutschland" ].compact.join(", ")
  end
  def display_name?
    id != 338
  end

  def initials
    return "?" if fullname.blank?
    fullname.split.map(&:first).join.upcase.first(2)
  end

  def expiration_date
    booked_at + 1.year
  end

  def to_param
    "#{id}-#{for_cano.parameterize}"
  end

  def self.users_count
    Rails.cache.fetch("users_count", expires_in: 1.day) do
      online.count
    end
  end
end

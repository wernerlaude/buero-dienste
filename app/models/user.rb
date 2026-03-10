class User < ApplicationRecord
  include Visitable

  before_create :generate_otp_secret
  # after_validation :geocode, on: %i[create update]
  geocoded_by :fulladdress

  after_save :clear_related_caches
  after_destroy :clear_related_caches


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

  validates :vorname, :nachname, :strasse, :plz, :ort, :email, presence: true
  validates_numericality_of :plz
  validates_length_of :plz, is: 5
  validates :datenschutz, acceptance: { message: " wurde gelesen und akzeptiert?" }
  validates :copyright, acceptance: { message: " wird beachtet?" }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true
  validates :bundesland_id, presence: { message: " wählen" }

  validates_length_of :other_offers, maximum: 255, allow_blank: true
  validate :at_least_one_phone_number

  validates :webpage, format: {
    with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/,
    message: "muss eine gültige HTTP/HTTPS URL sein",
    allow_blank: true
  }

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

  private
  def self.users_count
    Rails.cache.fetch("users_count", expires_in: 1.day) do
      online.count
    end
  end

  def clear_related_caches
    Offer.clear_offers_cache
    # Auch die grouped_offers Caches leeren
    offers.each do |offer|
      Rails.cache.delete([ "users_offers", offer.id ])
    end
  end

  def at_least_one_phone_number
    if telefon.blank? && mobile.blank?
      errors.add(:base, "Entweder Telefon oder Mobilnummer muss ausgefüllt sein")
    end
  end
end

class Offer < ApplicationRecord
  has_and_belongs_to_many :users

  after_save :clear_offers_cache
  after_destroy :clear_offers_cache

  scope :ranking, -> { order(:position) }
  scope :online, -> { where(online: true) }
  scope :off, -> { where(online: false) }
  scope :classic, -> { where(category: [ 1, 3, 4, 5 ]) }
  scope :digital, -> { where(category: 2) }

  CATEGORIES = {
    1 => "Klassische Bürodienste",
    2 => "Digitale Bürodienste",
    3 => "Business Coaching & Gründungsberatung",
    4 => "Betriebliches Gesundheitsmanagement",
    5 => "Management & Führung auf Zeit"
  }.freeze

  # Gecachte Abfrage für Online-Angebote
  def self.cached_offers
    Rails.cache.fetch("cached_offers", expires_in: 1.week) do
      ranking.online.includes(:users).to_a
    end
  end

  # Gecachte Abfrage gruppiert nach Kategorie
  def self.cached_by_category
    Rails.cache.fetch("offers_by_category", expires_in: 1.day) do
      ranking.online.includes(:users).group_by(&:category)
    end
  end

  # Cache leeren
  def self.clear_offers_cache
    Rails.cache.delete("cached_offers")
    Rails.cache.delete("offers_by_category")
    Rails.cache.delete("classic_offers_count")
    Rails.cache.delete("digital_offers_count")
  end

  # Gecachte Counts
  def self.classic_count
    Rails.cache.fetch("classic_offers_count", expires_in: 1.day) do
      online.classic.count
    end
  end

  def self.digital_count
    Rails.cache.fetch("digital_offers_count", expires_in: 1.day) do
      online.digital.count
    end
  end

  def standard_category?
    [ 1, 3, 4, 5 ].include?(category)
  end

  def digital_category?
    [ 2 ].include?(category)
  end

  def category_name
    CATEGORIES[category] || "Bürodienstleistungen"
  end

  def icon_name
    ICON_MAP[slug] || :briefcase
  end

  def to_param
    "#{id}-#{slug.parameterize}"
  end

  private

  def clear_offers_cache
    self.class.clear_offers_cache
  end
end
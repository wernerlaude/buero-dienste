class Bundesland < ApplicationRecord
  has_many :users
  has_many :offers, through: :users

  validates_presence_of :name

  scope :sortiert, -> { order(:name) }
  scope :with_users, -> { joins(:users).distinct }  # Nur Bundesländer mit aktiven Users

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def nil_zero?
    self.nil? || self == 0
  end

  private
  def self.cached_bundeslands
    Rails.cache.fetch("cached_bundeslands", expires_in: 1.year) do
      sortiert.to_a
    end
  end
end

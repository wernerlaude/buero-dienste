class Tag < ApplicationRecord
  scope :sortiert, -> { order(:name) }

  # Hilfsmethoden
  def has_verweis?
    verweis.present?
  end



  private

  def normalize_name
    self.name = name.strip.downcase if name.present?
  end

  def self.cached_tags
    Rails.cache.fetch("cached_tags", expires_in: 1.week) do
      sortiert.to_a
    end
  end
end

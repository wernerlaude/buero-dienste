class BlogPost < ApplicationRecord
  belongs_to :user
  has_many :counters, as: :countable

  validates_presence_of :title

  scope :online, -> { where(online: true) }
  scope :sortiert, -> { order(id: :desc) }
  scope :most_read, -> { order(count: :desc).limit(9) }

  def self.cached_blogs
    Rails.cache.fetch("cached_blogs", expires_in: 1.day) do
      sortiert.online.to_a
    end
  end

  def to_param
    "#{id}-#{meta_title.parameterize}"
  end
end

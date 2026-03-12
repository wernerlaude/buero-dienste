class BlogPost < ApplicationRecord
  belongs_to :user
  has_many :counters, as: :countable

  after_save :clear_blog_cache
  after_destroy :clear_blog_cache

  validates_presence_of :title

  scope :online, -> { where(online: true) }
  scope :sortiert, -> { order(id: :desc) }
  scope :most_read, -> { order(count: :desc).limit(9) }

  def self.cached_blogs
    Rails.cache.fetch("cached_blogs", expires_in: 1.week) do
      sortiert.online.to_a
    end
  end

  def to_param
    "#{id}-#{meta_title.parameterize}"
  end

  private

  def clear_blog_cache
    Rails.cache.delete("cached_blogs")
  end
end

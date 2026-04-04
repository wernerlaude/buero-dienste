class AccessToken < ApplicationRecord
  belongs_to :user
  before_create :set_token
  before_create :set_expiry

  validates :token, uniqueness: { case_sensitive: false }

  scope :active, -> { where("expires_at > ?", Time.current) }

  private

  def set_token
    begin
      self.token = SecureRandom.hex(32)
    end while self.class.exists?(token: token)
  end

  def set_expiry
    self.expires_at = 30.days.from_now
  end
end

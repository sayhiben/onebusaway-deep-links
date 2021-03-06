class AlertFeed < ApplicationRecord
  UPDATE_FREQUENCY = 60

  has_many :alert_feed_items
  belongs_to :region

  # Subclasses of AlertFeed are responsible for implementing #fetch and calling #super afterwards
  def fetch
    update!(last_fetched: Time.now)
  end

  def fetch_if_necessary
    fetch if last_fetched.blank? || last_fetched < UPDATE_FREQUENCY.seconds.ago
  end
end

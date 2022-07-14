module Coordinateable
  extend ActiveSupport::Concern

  def coordinates
    [latitude, longitude].reject(&:blank?).join(",")
    # array.reject(&:blank?).join(", ")
    # (latitude || "-").to_s + "," + (longitude || "-").to_s
    # "GPS: " + (latitude || "-").to_s + "," + (longitude || "-").to_s
  end

end
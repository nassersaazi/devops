module Countryable
  extend ActiveSupport::Concern

  def country_name
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end

  class_methods do
    def participating_countries
      %w{ BF BI BJ CD CI ET GH MG ML MW MZ NG RW SL TG TZ UG ZM ZW }
    end
  end
  
end
json.extract! equipment, :id, :name, :location_id, :ip4, :prefix4, :ip6, :prefix6, :mac, :protocol, :upstream_secret, :switchboard_secret, :require_message_authenticator, :nas_type, :created_at, :updated_at
json.url equipment_url(equipment, format: :json)

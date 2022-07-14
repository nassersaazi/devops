json.extract! radius_server, :id, :name, :server_type, :product, :ip4, :ip6, :protocol, :secret, :require_message_authenticator, :auth, :acct, :auth_port, :acct_port, :created_at, :updated_at
json.url radius_server_url(radius_server, format: :json)

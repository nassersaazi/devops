# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command
# or created alongside the database with db:setup.
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# Character.create(name: 'Luke', movie: movies.first)

# ['operator', 'provider'].each do |role|
#   Role.find_or_create_by({ name: role })
# end

# require 'securerandom'

african_confederation = Confederation.create_with(
  email: 'eduroam@ren.africa',
  tld: 'AFRICA'
).find_or_create_by(name: 'African eduroam Confederation')

etlr_nl = RadiusServer.create_with(
  server_type: :tlr,
  product: :radiator,
  ip4: '192.87.106.34',
  ip6: '',
  mac: nil,
  protocol: :udp,
  auth: true,
  acct: true,
  auth_port: 1812,
  acct_port: 1813,
  upstream_secret: SecureRandom.base64(12),
  monitor_secret:  SecureRandom.base64(12),
  switchboard_secret:  SecureRandom.base64(12)
)
.find_or_create_by(name: 'etlr.nl')

etlr_dk = RadiusServer.create_with(
  server_type: :tlr,
  product: :radiator,
  ip4: '130.225.242.109',
  ip6: '',
  mac: nil,
  protocol: :udp,
  auth: true,
  acct: true,
  auth_port: 1812,
  acct_port: 1813,
  upstream_secret: SecureRandom.base64(12),
  monitor_secret:  SecureRandom.base64(12),
  switchboard_secret:  SecureRandom.base64(12)
)
.find_or_create_by(name: 'etlr.dk')

ua_rp4 = RadiusServer.create_with(
            radiusable_id: african_confederation.id,
            radiusable_type: 'Confederation',
            server_type: :rp,
            product: :fr3,
            ip4: '196.32.213.90',
            ip6: '',
            mac: '52:54:00:92:31:69',
            protocol: :udp,
            auth: true,
            acct: true,
            auth_port: 1812,
            acct_port: 1813,
            upstream_secret: ENV['ETLR_SECRET'],
            monitor_secret:  SecureRandom.base64(12),
            switchboard_secret:  SecureRandom.base64(12)
          )
          .find_or_create_by(name: 'rp.ua')

########## new server from wacren #######

wacren_rp4 = RadiusServer.create_with(
            radiusable_id: african_confederation.id,
            radiusable_type: 'Confederation',
            server_type: :rp,
            product: :fr3,
            ip4: '196.216.191.12',
            ip6:  nil,
            mac: '52:54:00:82:07:64',
            protocol: :udp,
            auth: true,
            acct: true,
            auth_port: 1812,
            acct_port: 1813,
            upstream_secret: ENV['ETLR_SECRET'],
            monitor_secret:  SecureRandom.base64(12),
            switchboard_secret:  SecureRandom.base64(12)
          )
          .find_or_create_by(name: 'rp.wacren2')

##############

monitoring = RadiusServer.create_with(
            # radiusable_id: african_confederation.id,
            # radiusable_type: 'Confederation',
            server_type: :monitor,
            product: :other,
            ip4: '161.53.2.204',
            ip6: nil,
            mac: nil,
            protocol: :udp,
            auth: true,
            acct: false,
            auth_port: 1812,
            acct_port: 1813,
            upstream_secret: '',
            monitor_secret: '',
            switchboard_secret: ''
          )
          .find_or_create_by(name: 'monitoring')

switchboard = RadiusServer.create_with(
            radiusable_id: african_confederation.id,
            radiusable_type: 'Confederation',
            server_type: :switchboard,
            product: :other,
            ip4: '41.198.128.83',
            ip6: nil,
            mac: nil,
            protocol: :udp,
            auth: true,
            acct: false,
            auth_port: 1812,
            acct_port: 1813,
            upstream_secret: '',
            monitor_secret: '',
            switchboard_secret: ''
          )
          .find_or_create_by(name: 'switchboard')

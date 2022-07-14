# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_01_220702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "addressable_type"
    t.uuid "addressable_id"
    t.string "street"
    t.string "street2"
    t.string "pobox"
    t.string "city"
    t.string "zip"
    t.string "state"
    t.string "country_code", limit: 2, null: false
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.integer "altitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "confederations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "operator_id"
    t.string "email"
    t.string "tld"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operator_id"], name: "index_confederations_on_operator_id"
  end

  create_table "contacts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "contactable_type"
    t.uuid "contactable_id"
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.integer "contact_type", limit: 2, default: 0, null: false
    t.integer "privacy", limit: 2, default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable_type_and_contactable_id"
  end

  create_table "equipment", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "location_id"
    t.inet "ip4"
    t.integer "prefix4", default: 32
    t.inet "ip6"
    t.integer "prefix6", default: 128
    t.macaddr "mac"
    t.string "protocol", null: false
    t.string "upstream_secret"
    t.string "monitor_secret"
    t.string "switchboard_secret"
    t.boolean "require_message_authenticator", default: true, null: false
    t.string "nas_type", null: false
    t.string "nas_kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_equipment_on_location_id"
  end

  create_table "federations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "operator_id"
    t.integer "stage", default: 1, null: false
    t.string "identifier"
    t.string "tld", null: false
    t.string "info_url", null: false
    t.string "policy_url", null: false
    t.string "language", default: "en", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.uuid "confederation_id"
    t.index ["confederation_id"], name: "index_federations_on_confederation_id"
    t.index ["operator_id"], name: "index_federations_on_operator_id"
  end

  create_table "locations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organisation_id"
    t.string "name"
    t.uuid "identifier", default: -> { "gen_random_uuid()" }, null: false
    t.integer "stage", default: 1, null: false
    t.integer "transmission", default: 0, null: false
    t.string "venue_type"
    t.string "ssid", default: "eduroam", null: false
    t.uuid "address_id"
    t.uuid "contacts_id"
    t.string "wpa_mode"
    t.string "encryption_mode"
    t.integer "ap_no", default: 0
    t.integer "wired_no", default: 0
    t.boolean "port_restrict"
    t.boolean "transp_proxy"
    t.boolean "ipv6"
    t.boolean "nat"
    t.boolean "hs20"
    t.integer "availability", default: 0
    t.string "operation_hours", default: "Always"
    t.string "info_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_locations_on_address_id"
    t.index ["contacts_id"], name: "index_locations_on_contacts_id"
    t.index ["organisation_id"], name: "index_locations_on_organisation_id"
  end

  create_table "memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "user_id"
    t.uuid "organisation_id"
    t.boolean "operator", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organisation_id"], name: "index_memberships_on_organisation_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "organisations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "federation_id"
    t.string "country_code", limit: 2, null: false
    t.uuid "identifier", default: -> { "gen_random_uuid()" }, null: false
    t.string "eduroam_type", null: false
    t.string "venue_type"
    t.integer "stage", default: 1, null: false
    t.string "info_url", null: false
    t.string "policy_url", null: false
    t.string "language", default: "en", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "domain_name"
    t.index ["federation_id"], name: "index_organisations_on_federation_id"
  end

  create_table "radius_servers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "radiusable_type"
    t.uuid "radiusable_id"
    t.string "name", null: false
    t.string "server_type", null: false
    t.string "product"
    t.inet "ip4"
    t.inet "ip6"
    t.macaddr "mac"
    t.string "protocol", null: false
    t.string "upstream_secret"
    t.string "monitor_secret"
    t.string "switchboard_secret"
    t.boolean "require_message_authenticator", default: true, null: false
    t.boolean "auth", default: true, null: false
    t.boolean "acct", default: true, null: false
    t.integer "auth_port", default: 1812, null: false
    t.integer "acct_port", default: 1813, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["radiusable_type", "radiusable_id"], name: "index_radius_servers_on_radiusable_type_and_radiusable_id"
  end

  create_table "realms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "domain_name"
    t.uuid "organisation_id"
    t.string "test_user"
    t.string "test_password"
    t.boolean "generic", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "allow_subdomains", default: false
    t.index ["organisation_id"], name: "index_realms_on_organisation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "admin", default: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "confederations", "organisations", column: "operator_id"
  add_foreign_key "equipment", "locations"
  add_foreign_key "federations", "confederations"
  add_foreign_key "federations", "organisations", column: "operator_id"
  add_foreign_key "locations", "addresses"
  add_foreign_key "locations", "contacts", column: "contacts_id"
  add_foreign_key "locations", "organisations"
  add_foreign_key "memberships", "organisations"
  add_foreign_key "memberships", "users"
  add_foreign_key "realms", "organisations"
end

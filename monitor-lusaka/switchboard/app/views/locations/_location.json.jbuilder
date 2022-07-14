json.locationid location.identifier
unless location.address.coordinates.empty?
  json.coordinates location.address.coordinates
end
json.stage location.stage_value unless location.stage_value.nil?
json.type location.transmission_value unless location.transmission_value.nil?
json.loc_name [language] do |language|
  json.lang language
  json.data location.name
end
json.address [language] | ["en"] do |language|
  json.partial! 'addresses/address', address: location.address, language: language
end
json.location_type location.venue_type
json.contact do
  json.partial! 'shared/contact', collection: location.contacts, as: :contact
end
json.SSID location.ssid unless location.ssid.empty?
json.enc_level location.enc_level unless location.enc_level.empty?
json.AP_no location.ap_no unless location.ap_no.nil?
json.wired_no location.wired_no unless location.wired_no.nil?
json.tag location.tag unless location.tag.empty?
json.availability location.availability_value unless location.availability_value.nil?
json.operation_hour location.operation_hours unless location.operation_hours.empty?
json.ts location.updated_at
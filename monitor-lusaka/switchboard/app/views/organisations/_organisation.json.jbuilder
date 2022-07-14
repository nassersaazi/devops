json.instid institution.identifier
json.ROid institution.federation.identifier
json.type institution.eduroam_type_text
json.stage institution.stage_value 
unless institution.eduroam_type == "sp"
  if institution.realms.empty?
    json.set! :inst_realm, [""] 
  else
    json.inst_realm do
      json.array! institution.realms.pluck(:domain_name)
    end
  end
end
json.inst_name [institution.language] | ["en"] do |language| 
  json.lang language
  json.data institution.name
end
json.address [institution.language] | ["en"] do |language|
  json.partial! 'addresses/address', address: institution.address, language: language
end
unless institution.address.coordinates.empty?
  json.coordinates institution.address.coordinates
end
json.inst_type institution.venue_type_value
json.contact do
  json.partial! 'shared/contact', collection: institution.contacts, as: :contact
end
json.info_URL [institution.language] | ["en"] do |language|
  json.lang language
  json.data institution.info_url
end
json.policy_URL [institution.language] | ["en"] do |language|
  json.lang language
  json.data institution.policy_url
end
json.ts institution.updated_at
unless institution.locations.empty?
  json.location do
    json.partial! 'locations/location', collection: institution.locations, as: :location, language: institution.language
  end
end

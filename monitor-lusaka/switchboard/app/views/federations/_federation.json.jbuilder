json.RO do 
  json.ROid federation.identifier
  json.country federation.tld
  json.stage federation.stage_value
  unless federation.operator.address.coordinates.empty?
    json.coordinates federation.operator.address.coordinates
  end
  json.org_name [federation.language] | ["en"] do |language|
    json.lang language
    json.data federation.operator&.name
  end
  json.address [federation.language] | ["en"] do |language|
    json.partial! 'addresses/address', address: federation.operator.address, language: language
  end
  json.contact do
    json.partial! 'shared/contact', collection: federation.contacts, as: :contact
  end
  json.info_URL [federation.language] | ["en"] do |language|
    json.lang language
    json.data federation.info_url
  end
  json.policy_URL [federation.language] | ["en"] do |language|
    json.lang language
    json.data federation.policy_url
  end
  json.ts federation.updated_at
end
json.schema_version 2
json.institutions do
  json.institution do 
    json.partial! 'organisations/organisation', collection: @organisations, as: :institution
  end
end
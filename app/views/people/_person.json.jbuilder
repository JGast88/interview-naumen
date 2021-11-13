json.extract! person, :id, :fullname, :created_at, :updated_at
json.url person_url(person, format: :json)

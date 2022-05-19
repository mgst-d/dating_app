json.extract! user, :id, :first_name, :last_name, :birth, :sex, :work_id, :yourself, :latitude, :longitude, :foto,
              :created_at, :updated_at
json.url user_url(user, format: :json)
json.foto do
  json.array!(user.foto) do |foto|
    json.id foto.id
    json.url url_for(foto)
  end
end

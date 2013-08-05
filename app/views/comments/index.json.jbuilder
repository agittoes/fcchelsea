json.array! @comments do |comment|
  json.id comment.id
  json.text comment.text
  json.created_at comment.created_at
  json.user do
    json.id comment.user.id
    json.nickname comment.user.nickname
    json.first_name comment.user.first_name
    json.last_name comment.user.last_name
    json.image comment.user.image
  end
end
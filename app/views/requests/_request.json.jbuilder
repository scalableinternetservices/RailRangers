json.extract! request, :id, :requester_id, :requestee_id, :accepted, :created_at, :updated_at
json.url request_url(request, format: :json)

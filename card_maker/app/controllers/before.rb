before do
  content_type :json
  response.headers["Access-Control-Allow-Origin"] = '*'
end

# Before POST and PUT requests
before :accepted_verbs => ["POST", "PUT"] do
  begin
    @Params = JSON.parse(request.body.read)
  rescue Exception => e
    halt 400, e
  end
end
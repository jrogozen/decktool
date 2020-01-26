enable :cross_origin
set :allow_origin, :any
set :allow_methods, [:get, :post, :put, :delete, :options] 

set(:accepted_verbs) do |*verbs|
  condition do
    verbs.any?{|v| v == request.request_method}
  end
end

set(:not_accepted_verbs) do |*verbs|
  condition do
    !verbs.any?{|v| v == request.request_method}
  end
end
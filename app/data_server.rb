class DataServer < Sinatra::Base
  enable :logging

  post "/data", provides: "json" do

  end

  get "/" do

  end
end

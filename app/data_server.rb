class DataServer < Sinatra::Base
  configure do
    register Sinatra::Reloader
    enable :logging
    enable :reload_templates
  end

  get "/data" do
    slim :data
  end

  post "/data", provides: "json" do
    GenerateData.new(params).call.to_json
  end
end

# DB Config ==============================================================
set :config, YAML.load_file("#{SINATRA_ROOT}/config/database.yml")

# Custom Errors ==========================================================
class MyCustomError < RuntimeError;;end;

error MyCustomError do
  "Hmm... Something went wrong. " + request.env['sinatra.error'].message
end

# DataMapper ============================================================
DataMapper.setup(:default, "sqlite3://#{database_url}")
DataMapper.auto_upgrade!

# Requirements =========================================================== 
require 'models/models'
require 'models/report'
require 'routes/web'
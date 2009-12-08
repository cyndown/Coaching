require 'helpers/core_extensions'
require 'helpers/app_helpers'

def database_url
  path = ""
  path << Sinatra::Application.config["#{ENVIRONMENT}"]["path"]
  path << "/"
  path << Sinatra::Application.config["#{ENVIRONMENT}"]["filename"]
  return path
end

# Add app-specific helpers to Sinatra
helpers do
  include Kernel.const_get("#{APP_NAME.capitalize}")::Helpers  
  
  def logger
    LOGGER
  end
end
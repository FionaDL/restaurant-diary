class ApplicationController < Sinatra::Base

    enable :sessions
    set :session_secret, "restaurant_secret"
    register Sinatra::ActiveRecordExtension
    set :views, Proc.new { File.join(root, "../views/") }

    get '/' do
      erb :index
    end
end

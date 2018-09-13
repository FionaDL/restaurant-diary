require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "restaurant_secret"
  end

    get '/' do
      erb :index
    end

    helpers do
      def logged_in?
      	!!session[:id]
    	end

      def current_user
      	User.find(session[:id])
      end

      def unique
        a = self.all.map do |x|
          x.name
        end
        a.uniq
      end

    end
end

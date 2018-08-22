class User < ActiveRecord::Base
  has_many :unvisited_restaurants
  has_many :visited_restaurants

  has_secure_password
end

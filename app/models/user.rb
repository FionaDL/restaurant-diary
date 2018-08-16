class User < ActiveRecord::Base
  has_many :unvisitedrestaurants
  has_many :visitedrestaurants

  has_secure_password
end

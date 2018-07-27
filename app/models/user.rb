class User < ActiveRecord::Base
  has_many :UnvisitedRestaurants
  has_many :VisitedRestaurants

  has_secure_password
end

require './config/environment'



use Rack::MethodOverride
use UsersController
use UnvisitedRestaurantsController
use VisitedRestaurantsController
run ApplicationController

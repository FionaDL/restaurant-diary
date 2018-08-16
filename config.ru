require './config/environment'



use Rack::MethodOverride
use UserController
use UnvisitedController
use VisitedController
run ApplicationController

module Api
  class ApiController < ApplicationController # needs to inherit from application_controller?
    protect_from_forgery with: :null_session
  end
end

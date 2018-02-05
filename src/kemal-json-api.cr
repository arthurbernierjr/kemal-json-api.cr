require "kemal"
require "./kemal-json-api/*"
require "./kemal-json-api/adapters/*"
require "./kemal-json-api/models/*"
require "./kemal-json-api/resources/*"

module KemalJsonApi
  DEBUG = false

  ALL_ACTIONS = {} of ActionMethod => ActionType

  error 400 do |env|
    env.response.content_type = "application/vnd.api+json"
    {"status": "error", "message": "bad_request"}.to_json
  end

  error 401 do |env|
    env.response.content_type = "application/vnd.api+json"
    {"status": "error", "message": "not_authorized"}.to_json
  end

  error 404 do |env|
    env.response.content_type = "application/vnd.api+json"
    {"status": "error", "message": "not_found"}.to_json
  end

  error 500 do |env|
    env.response.content_type = "application/vnd.api+json"
    {"status": "error", "message": "internal_server_error"}.to_json
  end
end

require "../resource"
require "../models/mongo"

module KemalJsonApi
  class Resource::Mongo < KemalJsonApi::Resource
    class_getter resources = [] of Resource
    property! collection : String

    def initialize(name : String, @mongodb : KemalJsonApi::Adapter::Mongo, actions : ActionsList = ALL_ACTIONS, *, plural = "", prefix = "")
      # TODO: Ensure that name is singular
      @singular = name.to_s.downcase
      @collection = @singular
      @prefix = prefix.strip.empty? ? "" : prefix.strip
      @plural = plural.strip.empty? ? Resource.pluralize(@singular) : plural.strip
      @option_json = true
      @model = KemalJsonApi::Model::Mongo.new(collection, @mongodb)
      @resources.push self
      self.class.resources.push self
      setup_actions! actions
    end
  end
end
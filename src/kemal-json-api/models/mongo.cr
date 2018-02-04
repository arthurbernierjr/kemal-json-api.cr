require "../model"

module KemalJsonApi
  class Model::Mongo < KemalJsonApi::Model
    def initialize(@collection : String, @mongodb : KemalJsonApi::Adapter::Mongo)
    end

    def prepare_params(env : HTTP::Server::Context, *, json = true) : Hash(String, String)
      data = Hash(String, String).new
      args = json ? env.params.json.to_json : env.params.body.to_h
      if (args_ = args).class == Hash(String, String)
        data = args.as(Hash(String, String))
      else
        data = Hash(String, String).new
        JSON.parse(args.as(String)).each do |k, v|
          data[k.to_s] = v.to_s
        end
      end
      data
    end

    def create(data : Hash(String, String))
      ret = 0
      @mongodb.with_collection(@collection) do |coll|
        coll.insert(data)
        if (err = coll.last_error)
          ret = err["nInserted"].as(Int)
        end
      end
      ret
    end

    def read(id : Int | String)
      @mongodb.with_collection(@collection) do |coll|
        coll.find_one({"_id" => BSON::ObjectId.new(id)})
      end
    end

    def update(id : Int | String, data : Hash(String, String))
      ret = 0
      @mongodb.with_collection(@collection) do |coll|
        coll.update({"_id" => BSON::ObjectId.new(id)}, {"$set" => data})
        if (err = coll.last_error)
          ret = err["nModified"].as(Int)
        end
      end
      ret
    end

    def delete(id : Int | String)
      ret = false
      @mongodb.with_collection(@collection) do |coll|
        doc = coll.find_one({"_id" => BSON::ObjectId.new(id)})
        if doc
          #  TODO: remove find_one to use only remove?
          coll.remove({"_id" => BSON::ObjectId.new(id)})
          ret = true
        end
      end
      ret
    end

    def list
      results = [] of Hash(String, String)
      @mongodb.with_collection(@collection) do |coll|
        coll.find(BSON.new) do |doc|
          hash = Hash(String, String).new
          doc.each_pair do |k, v|
            hash[k] = v.value.to_s
          end
          results << hash
        end
      end
      results
    end
  end
end
require "../../spec_helper"

describe KemalJsonApi do
  describe KemalJsonApi::Adapter do
    describe KemalJsonApi::Adapter::Mongo do
      describe "#new" do
        it "initializes with values" do
          mongo = KemalJsonApi::Adapter::Mongo.new("localhost", 27017, "test")
          mongo.should be_a(KemalJsonApi::Adapter::Mongo)
          mongo.host.should eq "localhost"
          mongo.port.should eq 27017
          mongo.database_name.should eq "test"
        end
      end

      describe "#get_client" do
        it "is a Mongo::Client" do
          mongo = KemalJsonApi::Adapter::Mongo.new("localhost", 27017, "test")
          mongo.get_client.should be_a(Mongo::Client)
        end
      end

      describe "#get_database" do
        it "is a Mongo::Client" do
          mongo = KemalJsonApi::Adapter::Mongo.new("localhost", 27017, "test")
          mongo.get_database("test").should be_a(Mongo::Database)
        end
      end

      describe "#get_collection" do
        it "is a Mongo::Client" do
          mongo = KemalJsonApi::Adapter::Mongo.new("localhost", 27017, "test")
          mongo.get_collection("people").should be_a(Mongo::Collection)
        end
      end

      describe "#uri" do
        it "builds correct uri" do
          mongo = KemalJsonApi::Adapter::Mongo.new("testhost", 27017, "test")
          mongo.uri.should eq "mongodb://testhost:27017/test"
        end
      end
    end
  end
end

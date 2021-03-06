require "../spec_helper"

describe KemalJsonApi do
  describe KemalJsonApi::Resource do
    describe "#singular" do
      it "returns a default value for singular " do
        resource = TestResource.new adapter
        resource.singular.should be_a(String)
        resource.singular.should eq "test_resource"
      end

      it "returns the set value for singular " do
        resource = TestResource.new(adapter, singular: "trait")
        resource.singular.should be_a(String)
        resource.singular.should eq "trait"
      end
    end

    describe "#plural" do
      it "returns a default value for plural " do
        resource = TestResource.new adapter
        resource.plural.should be_a(String)
        resource.plural.should eq "test_resources"
      end

      it "returns the set value for plural " do
        resource = TestResource.new(adapter, plural: "traits")
        resource.singular.should be_a(String)
        resource.singular.should eq "test_resource"
        resource.plural.should be_a(String)
        resource.plural.should eq "traits"
      end
    end

    describe "#prefix" do
      it "returns a default value for prefix " do
        resource = TestResource.new adapter
        resource.prefix.should be_a(String)
        resource.prefix.should eq ""
      end

      it "returns the set value for prefix " do
        resource = TestResource.new(adapter, prefix: "prefix_")
        resource.prefix.should be_a(String)
        resource.prefix.should eq "prefix_"
      end
    end

    describe "#collection" do
      it "returns a default value for collection " do
        resource = TestResource.new adapter
        resource.collection.should be_a(String)
        resource.collection.should eq "test_resource"
      end

      it "returns the full value for collection " do
        resource = TestResource.new(adapter, prefix: "prefix_")
        resource.collection.should be_a(String)
        resource.collection.should eq "prefix_test_resource"
      end
    end

    describe "#create" do
      it "returns a String id on create" do
        result = TestResource.new(adapter).create({"data" => JSON::Any.new("data")})
        result.should be_a(String)
        result.should eq "550e8400-e29b-41d4-a716-446655440000"
      end
    end

    describe "#read" do
      it "returns a Hash on read" do
        result = TestResource.new(adapter).read("1")
        result.should be_a KemalJsonApi::Resource::Data
      end
    end

    describe "#update" do
      it "returns a Hash on update" do
        data = {"title" => JSON::Any.new("JSON API paints my bikeshed!")}
        result = TestResource.new(adapter).update("1", data)
        result.should be_a KemalJsonApi::Resource::Data
      end
    end

    describe "#delete" do
      it "returns a Hash on update" do
        result = TestResource.new(adapter).delete("1")
        result.should be_true
      end
    end

    describe "#list" do
      it "returns a Hash on list" do
        result = TestResource.new(adapter).list
        result.should be_a Array(KemalJsonApi::Resource::Data)
      end
    end
  end
end

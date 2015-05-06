require("spec_helper")

describe(Train) do

  describe("#name") do
    it("returns the name") do
        test_train = Train.new({:name => "MAX Red", :id => nil})
        expect(test_train.name()).to(eq("MAX Red"))
    end
  end

  describe("#id") do
    it("returns the id") do
      test_train = Train.new({:name => "MAX Red", :id => 1})
      expect(test_train.id()).to(eq(1))
    end
  end

  describe(".all") do
    it("starts off empty") do
      expect(Train.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a train by its ID number") do
      test_train = Train.new({:name => "MAX Red", :id => nil})
      test_train.save()
      test_train2 = Train.new({:name => "MAX Blue", :id => nil})
      test_train2.save()
      expect(Train.find(test_train2.id())).to(eq(test_train2))
    end
  end

  describe("#save") do
    it("lets you add a train to the train table") do
      test_train = Train.new({:name => "MAX Red", :id => nil})
      test_train.save()
      expect(Train.all()).to(eq([test_train]))
    end
  end

  describe("#==") do
    it("will return the same train if the train you entered has the same name and id") do
      test_train = Train.new({:name => "MAX Red", :id => nil})
      test_train2 = Train.new({:name => "MAX Red", :id => nil})
      expect(test_train).to(eq(test_train2))
    end
  end

  describe("#update") do
    it("update trains in the database") do
      test_train = Train.new({:name => "MAX Red", :id => nil})
      test_train.save()
      test_train.update({:name => "MAX Grey"})
      expect(test_train.name()).to(eq("MAX Grey"))
    end
    it("lets you add a city to an train") do
      test_city = City.new ({:name => "Portland", :id => nil})
      test_city.save()
      test_train = Train.new({:name => "MAX Red", :id => nil})
      test_train.save()
      test_train.update({:city_ids => [test_city.id()]})
      expect(test_train.cities()).to(eq([test_city]))
    end
  end

  describe("#delete") do
    it("lets you delete a train from the database") do
      test_train = Train.new({:name => "MAX Red", :id => nil})
      test_train.save()
      test_train2 = Train.new({:name => "MAX Black", :id => nil})
      test_train2.save()
      test_train.delete()
      expect(Train.all()).to(eq([test_train2]))
    end
  end

  describe("#cities") do
    it("returns all of the cities a particular train goes to") do
      test_city = City.new({:name => "Portland", :id => nil})
      test_city.save()
      test_city2 = City.new({:name => "Vancouver", :id => nil})
      test_city2.save()
      test_train = Train.new({:name => "Max Red", :id => nil})
      test_train.save()
      test_train.update({:city_ids => [test_city.id()]})
      test_train.update({:city_ids => [test_city2.id()]})
      expect(test_train.cities()).to(eq([test_city, test_city2]))
    end
  end

end

require("spec_helper")

describe(City) do

  describe("#name") do
    it("returns the name of the city") do
      test_city = City.new({:name => "Portland", :id => nil})
      expect(test_city.name()).to(eq("Portland"))
    end
  end

  describe("#id") do
    it("return id of city") do
      test_city = City.new({:name => "portland", :id => 1})
      expect(test_city.id()).to(eq(1))
    end
  end

  describe(".all") do
    it("doesn't have shit yet LOL") do
      expect(City.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a city by its ID number") do
      test_city = City.new({:name => "Portland", :id => nil})
      test_city.save()
      test_city2 = City.new({:name => "Vancouver", :id => nil})
      test_city2.save()
      expect(City.find(test_city2.id())).to(eq(test_city2))
    end
  end

  describe("#==") do
    it("is the same City if it has the same name and id") do
      test_city = City.new({:name => "Portland", :id => nil})
      test_city2 = City.new({:name => "Portland", :id => nil})
      expect(test_city).to(eq(test_city2))
    end
  end

  describe("#update") do
    it('lets you add a train to a city') do
      city = City.new({:name => "portland", :id => nil})
      city.save()
      red = Train.new({:name => "MAX Red", :id => nil})
      red.save()
      blue = Train.new({:name => "MAX Blue", :id => nil})
      blue.save()
      city.update({:train_ids => [red.id(), blue.id()]})
      expect(city.trains()).to(eq([red, blue]))
    end
  end


end

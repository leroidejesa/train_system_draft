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

end

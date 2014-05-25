require 'byebug'

class Building
  attr_reader :locations

  def initialize(locations)
    @locations = locations
  end

  def coordinates
    coords = []
    (0...locations[1]).each do |i|
      coords << [locations[0], i]
    end

    (locations[0]..locations[2]).each do |i|
      coords << [i, locations[1]]
    end

    (0...locations[1]).to_a.reverse.each do |i|
      coords << [locations[2], i]
    end

    coords
  end
end

describe Building do
  let(:building_1) { Building.new([1,2,3]) }
  let(:building_2) { Building.new([2,4,6]) }

  it "is valid" do
    expect(building_1).to be_an_instance_of Building
  end

  describe "#locations" do
    it "returns the locations" do
      expect(building_1.locations).to eq([1,2,3])
    end
  end

  describe "#coordinates" do
    it "returns the buildings's coordinates" do
      expect(building_1.coordinates).to eq([[1,0], [1,1], [1,2], [2,2], [3,2], [3,1], [3,0]])
      expect(building_2.coordinates).to eq([[2,0], [2,1], [2,2], [2,3], [2,4], [3,4], [4,4], [5,4], [6,4], [6,3], [6,2], [6,1], [6,0]])
    end
  end
end

require 'byebug'

class Building
  attr_reader :locations

  def initialize(locations)
    @locations = locations
  end

  def combine_coordinates(building)
    intersections = coordinates & building.coordinates
    if intersections.empty?
      coordinates + building.coordinates
    elsif intersections.count == 1
      first = coordinates.slice_before(intersections[0]).to_a[0]
      second = building.coordinates.slice_before(intersections[0]).to_a[1]
      first + second
    else
      first = coordinates.slice_before(intersections[0]).to_a[0]
      second = building.coordinates.slice_before(intersections[0]).to_a[1].slice_before(intersections[1]).to_a[0]
      third = coordinates.slice_before(intersections[1]).to_a[1]
      first + second + third
    end
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
  let(:building_3) { Building.new([4,5,5]) }
  let(:building_4) { Building.new([7,3,11]) }

  it "is valid" do
    expect(building_1).to be_an_instance_of Building
  end

  describe "#combine_coordinates" do
    it "returns the combined coordinates of the buildings" do
      expect(building_1.combine_coordinates(building_2)).to eq([[1,0], [1,1], [1,2], [2,2], [2,3], [2,4], [3,4], [4,4], [5,4], [6,4], [6,3], [6,2], [6,1], [6,0]])
      expect(building_2.combine_coordinates(building_3)).to eq([[2,0], [2,1], [2,2], [2,3], [2,4], [3,4], [4,4], [4,5], [5,5], [5,4], [6,4], [6, 3], [6,2], [6,1], [6,0]])
      expect(building_2.combine_coordinates(building_4)).to eq([[2,0], [2,1], [2,2], [2,3], [2,4], [3,4], [4,4], [5,4], [6,4], [6,3], [6,2], [6,1], [6, 0], [7, 0], [7,1], [7,2], [7,3], [8,3], [9,3], [10,3], [11,3], [11,2], [11,1], [11,0]])
    end
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

require 'byebug'

class Skyline
  def self.coordinates(*buildings)
    coordinates = buildings.delete_at(0).to_coordinates
    while buildings.any?
      coordinates = coordinates.combine(buildings.delete_at(0).to_coordinates)
    end
    coordinates
  end
end

class Array
  def combine(other)
    intersections = self & other
    if intersections.empty?
      self + other
    elsif intersections.count == 1
      first = self.slice_before(intersections[0]).to_a[0]
      second = other.slice_before(intersections[0]).to_a[1]
      first + second
    else
      first = self.slice_before(intersections[0]).to_a[0]
      second = other.slice_before(intersections[0]).to_a[1].slice_before(intersections[1]).to_a[0]
      third = self.slice_before(intersections[1]).to_a[1]
      first + second + third
    end
  end

  def to_coordinates
    coordinates = []

    (0...self[1]).each do |i|
      coordinates << [self[0], i]
    end

    (self[0]..self[2]).each do |i|
      coordinates << [i, self[1]]
    end

    (0...self[1]).to_a.reverse.each do |i|
      coordinates << [self[2], i]
    end

    coordinates
  end
end

describe Array do
  let(:array_1) { [1,2,3] }
  let(:array_2) { [2,4,6] }
  let(:array_3) { [4,5,5] }
  let(:array_4) { [7,3,11] }
  let(:coord_1) { [[1,0], [1,1], [1,2], [2,2], [3,2], [3,1], [3,0]] }
  let(:coord_2) { [[2,0], [2,1], [2,2], [2,3], [2,4], [3,4], [4,4], [5,4], [6,4], [6,3], [6,2], [6,1], [6,0]] }
  let(:coord_3) { [[4,0], [4,1], [4,2], [4,3], [4,4], [4,5], [5,5], [5,4], [5,3], [5,2], [5,1], [5,0]] }
  let(:coord_4) { [[7,0], [7,1], [7,2], [7,3], [8,3], [9,3], [10,3], [11,3], [11,2], [11,1], [11,0]] }

  describe "#combine" do
    it "returns the combined coordinates of the buildings" do
      expect(coord_1.combine(coord_2)).to eq([[1,0], [1,1], [1,2], [2,2], [2,3], [2,4], [3,4], [4,4], [5,4], [6,4], [6,3], [6,2], [6,1], [6,0]])
      expect(coord_2.combine(coord_3)).to eq([[2,0], [2,1], [2,2], [2,3], [2,4], [3,4], [4,4], [4,5], [5,5], [5,4], [6,4], [6,3], [6,2], [6,1], [6,0]])
      expect(coord_2.combine(coord_4)).to eq([[2,0], [2,1], [2,2], [2,3], [2,4], [3,4], [4,4], [5,4], [6,4], [6,3], [6,2], [6,1], [6,0], [7,0], [7,1], [7,2], [7,3], [8,3], [9,3], [10,3], [11,3], [11,2], [11,1], [11,0]])
    end
  end

  describe "#to_coordinates" do
    it "returns the triple as coordinates" do
      expect(array_1.to_coordinates).to eq(coord_1)
      expect(array_2.to_coordinates).to eq(coord_2)
      expect(array_3.to_coordinates).to eq(coord_3)
      expect(array_4.to_coordinates).to eq(coord_4)
    end
  end
end

describe Skyline do
  let(:building_1) { [1,2,3] }
  let(:building_2) { [2,4,6] }
  let(:building_3) { [4,5,5] }
  let(:building_4) { [7,3,11] }

  describe ".coordinates" do
    it "returns the skyline coordinates" do
      expect(Skyline.coordinates(building_1, building_2, building_3)).to eq([[1,0], [1,1], [1,2], [2,2], [2,3], [2,4], [3,4], [4,4], [4,5], [5,5], [5,4], [6,4], [6,3], [6,2], [6,1], [6,0]])
    end
  end
end

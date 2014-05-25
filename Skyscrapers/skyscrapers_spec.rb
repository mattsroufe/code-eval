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
      self + (self.last[0] + 1...other.first[0]).map { |e| [e,0] } + other
    elsif intersections.count == 1
      first = self.slice_before(intersections[0]).to_a[0]
      second = other.slice_before(intersections[0]).to_a[1]
      first + second
    else
      first = self.slice_before(intersections[0]).to_a[0]
      second = other.slice_before(intersections[0]).to_a.last.slice_before(intersections[1]).to_a[0]
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

  def draw
    var = self[0][0]
    arr = [var]
    x_or_y = 0
    self.each do |e|
      if e[x_or_y] != var
        arr << var = e[x_or_y == 1 ? 0 : 1]
        x_or_y = x_or_y == 1 ? 0 : 1
      end
    end
    arr << 0
    arr.join(' ')
  end
end

describe Array do
  let(:array_1) { [1,2,3] }
  let(:array_2) { [2,4,6] }
  let(:array_3) { [4,5,5] }
  let(:array_4) { [7,3,11] }
  let(:array_5) { [1,2,6] }
  let(:array_6) { [9,23,22] }
  let(:coord_1) { [[1,0], [1,1], [1,2], [2,2], [3,2], [3,1], [3,0]] }
  let(:coord_2) { [[2,0], [2,1], [2,2], [2,3], [2,4], [3,4], [4,4], [5,4], [6,4], [6,3], [6,2], [6,1], [6,0]] }
  let(:coord_3) { [[4,0], [4,1], [4,2], [4,3], [4,4], [4,5], [5,5], [5,4], [5,3], [5,2], [5,1], [5,0]] }
  let(:coord_4) { [[7,0], [7,1], [7,2], [7,3], [8,3], [9,3], [10,3], [11,3], [11,2], [11,1], [11,0]] }
  let(:coord_5) { [[1,0], [1,1], [1,2], [2,2], [3,2], [4,2], [5,2], [6,2], [6,1], [6,0]] }
  let(:coord_6) { [[9,0], [9,1], [9,2], [9,3], [9,4], [9,5], [9,6], [9,7], [9,8], [9,9], [9,10], [9,11], [9,12], [9,13], [9,14], [9,15], [9,16], [9,17], [9,18], [9,19], [9,20], [9,21], [9,22], [9,23], [10,23], [11,23], [12,23], [13,23], [14,23], [15,23], [16,23], [17,23], [18,23], [19,23], [20,23], [21,23], [22,23], [22,22], [22,21], [22,20], [22,19], [22,18], [22,17], [22,16], [22,15], [22,14], [22,13], [22,12], [22,11], [22,10], [22,9], [22,8], [22,7], [22,6], [22,5], [22,4], [22,3], [22,2], [22,1], [22,0]] }

  describe "#combine" do
    it "returns the combined coordinates of the buildings" do
      expect(coord_1.combine(coord_2)).to eq([[1,0], [1,1], [1,2], [2,2], [2,3], [2,4], [3,4], [4,4], [5,4], [6,4], [6,3], [6,2], [6,1], [6,0]])
      expect(coord_2.combine(coord_3)).to eq([[2,0], [2,1], [2,2], [2,3], [2,4], [3,4], [4,4], [4,5], [5,5], [5,4], [6,4], [6,3], [6,2], [6,1], [6,0]])
      expect(coord_2.combine(coord_4)).to eq([[2,0], [2,1], [2,2], [2,3], [2,4], [3,4], [4,4], [5,4], [6,4], [6,3], [6,2], [6,1], [6,0], [7,0], [7,1], [7,2], [7,3], [8,3], [9,3], [10,3], [11,3], [11,2], [11,1], [11,0]])
      expect(coord_5.combine(coord_6)).to eq([[1,0], [1,1], [1,2], [2,2], [3,2], [4,2], [5,2], [6,2], [6,1], [6,0], [7,0], [8,0], [9,0], [9,1], [9,2], [9,3], [9,4], [9,5], [9,6], [9,7], [9,8], [9,9], [9,10], [9,11], [9,12], [9,13], [9,14], [9,15], [9,16], [9,17], [9,18], [9,19], [9,20], [9,21], [9,22], [9,23], [10,23], [11,23], [12,23], [13,23], [14,23], [15,23], [16,23], [17,23], [18,23], [19,23], [20,23], [21,23], [22,23], [22,22], [22,21], [22,20], [22,19], [22,18], [22,17], [22,16], [22,15], [22,14], [22,13], [22,12], [22,11], [22,10], [22,9], [22,8], [22,7], [22,6], [22,5], [22,4], [22,3], [22,2], [22,1], [22,0]])
    end
  end

  describe "#to_coordinates" do
    it "returns the triple as coordinates" do
      expect(array_1.to_coordinates).to eq(coord_1)
      expect(array_2.to_coordinates).to eq(coord_2)
      expect(array_3.to_coordinates).to eq(coord_3)
      expect(array_4.to_coordinates).to eq(coord_4)
      expect(array_5.to_coordinates).to eq(coord_5)
      expect(array_6.to_coordinates).to eq(coord_6)
    end
  end

  describe "#draw" do
    it "returns coordinates as a line" do
      expect(coord_1.draw).to eq('1 2 3 0')
      expect(coord_2.draw).to eq('2 4 6 0')
      expect(Skyline.coordinates([1,2,3],[2,4,6],[4,5,5],[7,3,11],[9,2,14],[13,7,15],[14,3,17]).draw).to eq('1 2 2 4 4 5 5 4 6 0 7 3 11 2 13 7 15 3 17 0')
      expect(Skyline.coordinates([2,22,3],[6,12,10],[15,6,21]).draw).to eq('2 22 3 0 6 12 10 0 15 6 21 0')
      expect(Skyline.coordinates([1,2,6],[9,23,22],[22,6,24],[8,14,19],[23,12,30]).draw).to eq('1 2 6 0 8 14 9 23 22 6 23 12 30 0')
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

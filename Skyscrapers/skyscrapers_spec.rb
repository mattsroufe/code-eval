require 'byebug'

class Skyline
  def initialize(*dimensions)
    @buildings = dimensions.map do |dimensions|
      Building.new(dimensions)
    end
  end

  def draw
    points = roof_lines.delete_at(0)
    x = points[0] + 1

    roof_lines.each do |line|
      if line[1] == points.last
        x = line[0] + 1
      elsif line[0] !=  x
        points.push(x, 0, line[0], line[1])
        x = line[0] + 1
      else
        points.push(x, line[1])
        x += 1
      end
    end

    points.push(x, 0).join(' ')
  end

  def roof_lines
    @buildings.each_with_object({}) do |building, hash|
      building.roof_lines.each do |key, value|
        hash[key] = value if value > hash[key].to_i
      end
    end.sort
  end
end

class Building
  def initialize(dimensions)
    @dimensions = dimensions
  end

  def roof_lines
    (@dimensions[0]...@dimensions[2]).each_with_object({}) { |i, hash| hash[i] = @dimensions[1] }
  end
end

describe Skyline do
  let(:skyline) { Skyline.new([]) }

  describe "#draw" do
    it "returns coordinates as a line" do
      expect(Skyline.new([1,2,3],[2,4,6],[4,5,5],[7,3,11],[9,2,14],[13,7,15],[14,3,17]).draw).to eq('1 2 2 4 4 5 5 4 6 0 7 3 11 2 13 7 15 3 17 0')
      expect(Skyline.new([13,7,15],[2,4,6],[1,2,3],[4,5,5],[7,3,11],[9,2,14],[14,3,17]).draw).to eq('1 2 2 4 4 5 5 4 6 0 7 3 11 2 13 7 15 3 17 0')
      expect(Skyline.new([2,22,3],[6,12,10],[15,6,21]).draw).to eq('2 22 3 0 6 12 10 0 15 6 21 0')
      expect(Skyline.new([1,2,6],[9,23,22],[22,6,24],[8,14,19],[23,12,30]).draw).to eq('1 2 6 0 8 14 9 23 22 6 23 12 30 0')
    end
  end

  describe "#roof_lines" do
    it "returns the roof lines" do
      expect(Skyline.new([1,2,3]).roof_lines).to eq([[1, 2], [2, 2]])
      expect(Skyline.new([1,2,3], [2,4,6]).roof_lines).to eq([[1, 2], [2, 4], [3, 4], [4, 4], [5, 4]])
    end
  end
end

describe Building do
  describe "#roof_lines" do
    it "returns the building's roof lines" do
      expect(Building.new([2,4,6]).roof_lines).to eq({2 => 4, 3 => 4, 4 => 4, 5 => 4})
    end
  end
end

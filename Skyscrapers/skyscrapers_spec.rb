require 'byebug'

class Skyline
  def initialize(*dimensions)
    @buildings = dimensions.map do |dimensions|
      Building.new(dimensions)
    end
  end

  def draw
    roof_lines.each_with_object([]) do |line, points|
      if points.empty?
        points.push(line.start_point, line.height, line.end_point)
      elsif line.height == points[-2]
        points[-1] = line.end_point
      elsif line.start_point != points.last
        points.push(0, line.start_point, line.height, line.end_point)
      else
        points.push(line.height, line.end_point)
      end
    end.push(0).join(' ')
  end

  def roof_lines
    @buildings.each_with_object([]) do |building, lines|
      building.roof_lines.each do |roof_line|
        lines.delete_if { |line| line.start_point == roof_line.start_point && line.height < roof_line.height }
        lines.push(roof_line) unless lines.any? { |line| line.start_point == roof_line.start_point }
      end
    end.sort_by(&:start_point)
  end
end

class Building
  def initialize(dimensions)
    @dimensions = dimensions
  end

  def roof_lines
    (@dimensions[0]...@dimensions[2]).map do |i|
      Line.new(i, i + 1, @dimensions[1])
    end
  end
end

Line = Struct.new(:start_point, :end_point, :height)

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
      expect(Skyline.new([1,2,3]).roof_lines).to eq([Line.new(1, 2, 2), Line.new(2, 3, 2)])
      expect(Skyline.new([1,2,3], [2,4,6]).roof_lines).to eq(
        [Line.new(1,2,2), Line.new(2,3,4), Line.new(3,4,4), Line.new(4,5,4), Line.new(5,6,4)]
      )
    end
  end
end

describe Building do
  describe "#roof_lines" do
    it "returns the building's roof lines" do
      expect(Building.new([2,4,6]).roof_lines).to eq(
        [Line.new(2,3,4), Line.new(3,4,4), Line.new(4,5,4), Line.new(5,6,4)]
      )
    end
  end
end

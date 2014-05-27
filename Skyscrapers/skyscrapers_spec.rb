require 'byebug'

class Skyline
  def self.building_blocks(*buildings)
    buildings.each_with_object([]) do |building, building_blocks|
      building.blocks.each do |building_block|
        building_blocks << building_block unless building_blocks.include?(building_block)
      end
    end
  end
end

class Array
  def outline
    sort_by { |e| [e[0], e[1]] }.group_by(&:first).values.map(&:last)
  end

  def draw
    points = delete_at(0)
    x = points[0] + 1

    each do |e|
      if e[1] == points.last
        x = e[0] + 1
      elsif e[0] !=  x
        points.push(x, 0, e[0], e[1])
        x = e[0] + 1
      else
        points.push(x, e[1])
        x += 1
      end
    end

    points.push(x, 0).join(' ')
  end

  def blocks
    (self[0]...self[2]).to_a.product((1..self[1]).to_a)
  end
end

describe Array do
  describe "#outline" do
    it "returns the outermost set of building blocks" do
      expect([1,2,3].blocks.outline).to eq([[1, 2], [2, 2]])
    end
  end

  describe "#draw" do
    it "returns coordinates as a line" do
      expect([[1,1]].draw).to eq('1 1 2 0')
      expect([[1,2], [2,2]].draw).to eq('1 2 3 0')
      expect([[1,2], [2,2], [4,1]].draw).to eq('1 2 3 0 4 1 5 0')
      expect([[1,2], [2,2], [5,1]].draw).to eq('1 2 3 0 5 1 6 0')
      expect([[1,2], [2,2], [3,3]].draw).to eq('1 2 3 3 4 0')
      expect([[1,2], [2,2], [3,3], [4,1], [5,1], [6,1]].draw).to eq('1 2 3 3 4 1 7 0')
      expect(Skyline.building_blocks([1,2,3],[2,4,6],[4,5,5],[7,3,11],[9,2,14],[13,7,15],[14,3,17]).outline.draw).to eq('1 2 2 4 4 5 5 4 6 0 7 3 11 2 13 7 15 3 17 0')
      expect(Skyline.building_blocks([13,7,15],[2,4,6],[1,2,3],[4,5,5],[7,3,11],[9,2,14],[14,3,17]).outline.draw).to eq('1 2 2 4 4 5 5 4 6 0 7 3 11 2 13 7 15 3 17 0')
      expect(Skyline.building_blocks([2,22,3],[6,12,10],[15,6,21]).outline.draw).to eq('2 22 3 0 6 12 10 0 15 6 21 0')
      expect(Skyline.building_blocks([1,2,6],[9,23,22],[22,6,24],[8,14,19],[23,12,30]).outline.draw).to eq('1 2 6 0 8 14 9 23 22 6 23 12 30 0')
    end
  end

  describe "#blocks" do
    it "returns the builing's blocks" do
      expect([1,2,3].blocks).to eq([[1, 1], [1, 2], [2, 1], [2, 2]])
    end
  end
end

describe Skyline do
  let(:building_1) { [1,2,3] }
  let(:building_2) { [2,4,6] }
  let(:building_3) { [4,5,5] }
  let(:building_4) { [7,3,11] }

  describe ".building_blocks" do
    it "returns the building blocks" do
      expect(Skyline.building_blocks(building_1)).to eq([[1,1],[1,2],[2,1],[2,2]])
      expect(Skyline.building_blocks(building_1, building_2)).to eq([[1,1],[1,2],[2,1],[2,2],[2,3],[2,4],[3,1],[3,2],[3,3],[3,4],[4,1],[4,2],[4,3],[4,4],[5,1],[5,2],[5,3], [5,4]])
    end
  end
end

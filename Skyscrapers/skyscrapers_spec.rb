class Building
  attr_reader :locations

  def initialize(locations)
    @locations = locations
  end
end

describe Building do
  let(:building) { Building.new([1,2,3]) }

  it "is valid" do
    expect(building).to be_an_instance_of Building
  end

  describe "#locations" do
    it "returns the locations" do
      expect(building.locations).to eq([1,2,3])
    end
  end
end

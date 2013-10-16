require 'department'

describe Department do
  let(:department) {create(:department)}

  it "has avalid department" do
    department.should be_valid
  end
end

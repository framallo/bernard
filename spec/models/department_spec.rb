require 'spec_helper'

describe Department do
  let(:department) { Department.first }

  it "has avalid department" do
    department.should be_valid
  end
end

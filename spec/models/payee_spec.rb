require 'spec_helper'

describe Payee do
  let(:payee) {create(:payee)}

  it "has a valid payee" do
    payee.should be_valid
  end
end

require 'spec_helper'

describe Payee do
  let(:payee) { Payee.first }

  it "has a valid payee" do
    payee.should be_valid
  end
end

require 'spec_helper'
describe 'validate FactoryGirl factories' do
  FactoryGirl.factories.each do |factory|
    context "with factory for: #{factory.name}" do
      subject { FactoryGirl.build(factory.name) }
      
      it "is valid" do
        subject.should be_valid if subject.class.ancestors.include?(ActiveRecord::Base)
      end
    end
  end
end


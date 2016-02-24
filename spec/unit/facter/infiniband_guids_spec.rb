require 'spec_helper'

describe 'infiniband_guids fact' do

  before :each do
    Facter.clear
    Facter.fact(:kernel).stubs(:value).returns("Linux")
    Facter::Core::Execution.stubs(:which).with("ibstat").returns("/usr/sbin/ibstat")
  end

  it "should return a single GUID" do
    Facter::Core::Execution.expects(:exec).with("/usr/sbin/ibstat -p").returns("0x0000000000000001")
    expect(Facter.fact(:infiniband_guids).value).to eq('0x0000000000000001')
  end

  it "should return multiple GUIDs" do
    Facter::Core::Execution.expects(:exec).with("/usr/sbin/ibstat -p").returns("0x0000000000000001\n0x0000000000000002")
    expect(Facter.fact(:infiniband_guids).value).to eq('0x0000000000000001,0x0000000000000002')
  end

  it "should not be present if ibstat not found" do
    Facter::Core::Execution.stubs(:which).with("ibstat").returns(nil)
    expect(Facter.fact(:infiniband_guids).value).to be nil
  end

  it "should not be present if ibstat -p returns nil" do
    Facter::Core::Execution.expects(:exec).with("/usr/sbin/ibstat -p").returns(nil)
    expect(Facter.fact(:infiniband_guids).value).to be nil
  end

  it "should not be present if ibstat -p returns an empty string" do
    Facter::Core::Execution.expects(:exec).with("/usr/sbin/ibstat -p").returns('')
    expect(Facter.fact(:infiniband_guids).value).to be nil
  end
end

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ip2proxy" do
  it "work correctly with ipv4" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/IP2PROXY-IP-PROXYTYPE-COUNTRY-REGION-CITY-ISP.SAMPLE.BIN")
    record = i2p.getAll('1.0.241.135')
    record.should_not be_nil
    record['is_proxy'].should == 1
    i2p.close()
  end

  it "work correctly with ipv6" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/IP2PROXY-IP-PROXYTYPE-COUNTRY-REGION-CITY-ISP.SAMPLE.BIN")
    record = i2p.getAll('2001::')
    record.should_not be_nil
    record['is_proxy'].should == 0
    i2p.close()
  end

end

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ip2proxy" do
  it "work correctly with invalid ip" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_all('1.0.0.x')
    expect(record['country_short']).to eq 'INVALID IP ADDRESS'
  end

  it "work correctly with get_all ipv4" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_all('1.0.0.8')
    expect(record['country_short']).to eq '-'
  end

  it "work correctly with get_country_short" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_country_short('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_country_long" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_country_long('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_region" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_region('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_city" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_city('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_isp" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_isp('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_domain" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_domain('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_usagetype" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_usagetype('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_asn" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_asn('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_as" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_as('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_last_seen" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_last_seen('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_threat" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_threat('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with is_proxy" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.is_proxy('1.0.0.8')
    expect(record).to eq 0
  end

  it "work correctly with get_proxytype" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_proxytype('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_provider" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_provider('1.0.0.8')
    expect(record).to eq '-'
  end

  it "work correctly with get_fraud_score" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_fraud_score('1.0.0.8')
    expect(record).to eq '0'
  end

  it "work correctly with get_all ipv6" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_all('2c0f:ffa0::4')
    expect(record['country_short']).to eq '-'
  end

  it "work correctly with get_module_version" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_module_version()
    expect(record).to eq '3.4.0'
  end

  it "work correctly with get_package_version" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_package_version()
    expect(record).to eq '12'
  end

  it "work correctly with get_database_version" do
    i2p = Ip2proxy.new.open(File.dirname(__FILE__) + "/assets/PX12.SAMPLE.BIN")
    record = i2p.get_database_version()
    expect(record).to eq '2025.2.5'
  end
end

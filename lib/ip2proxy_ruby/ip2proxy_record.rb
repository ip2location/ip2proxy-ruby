class Ip2ProxyRecord 
  def self.init(database, ip_version)
    cls = Class.new(BinData::Record)
    cls.class_eval {
      endian :little
      i2p_ip_data :ip_from, :ip_version => ip_version
      database.each do |col|
        if col.first == :country
          i2p_string_data :country_short
          i2p_string_data :country_long, :country_long => true
        else
          i2p_string_data col.first
        end
      end
      
      i2p_ip_data :ip_to, :ip_version => ip_version
    }
    cls 
  end
end
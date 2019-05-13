require 'bindata'
require 'ipaddr'
require_relative 'ip2proxy_ruby/ip2proxy_config'
require_relative 'ip2proxy_ruby/i2p_database_config'
require_relative 'ip2proxy_ruby/i2p_string_data'
require_relative 'ip2proxy_ruby/i2p_ip_data'
require_relative 'ip2proxy_ruby/ip2proxy_record'

class Ip2proxy
  attr_accessor :record_class4, :record_class6, :v4, :file, :db_index, :count, :base_addr, :ipno, :record, :database, :columns, :ip_version, :ipv4databasecount, :ipv4databaseaddr, :ipv4indexbaseaddr, :ipv6databasecount, :ipv6databaseaddr, :ipv6indexbaseaddr, :databaseyear, :databasemonth, :databaseday 

  VERSION = '2.0.0'
  FIELD_NOT_SUPPORTED = 'NOT SUPPORTED'
  INVALID_IP_ADDRESS = 'INVALID IP ADDRESS'

  def open(url)
    self.file = File.open(File.expand_path url, 'rb')
    i2p = Ip2proxyConfig.read(file)
    self.db_index = i2p.databasetype
    self.columns = i2p.databasecolumn + 0
    self.databaseyear = 2000 + i2p.databaseyear
    self.databasemonth = i2p.databasemonth
    self.databaseday = i2p.databaseday
    self.database = I2pDbConfig.setup_database(self.db_index)
    self.ipv4databasecount = i2p.ipv4databasecount
    self.ipv4databaseaddr = i2p.ipv4databaseaddr
    self.ipv6databasecount = i2p.ipv6databasecount
    self.ipv6databaseaddr = i2p.ipv6databaseaddr
    self.ipv4indexbaseaddr = i2p.ipv4indexbaseaddr
    self.ipv6indexbaseaddr = i2p.ipv6indexbaseaddr
    self.record_class4 = (Ip2ProxyRecord.init database, 4)
    self.record_class6 = (Ip2ProxyRecord.init database, 6)
    self
  end

  def close()
    self.file.close
  end

  def get_module_version()
    return VERSION
  end

  def get_package_version()
    return (self.db_index).to_s
  end

  def get_database_version()
    return (self.databaseyear).to_s + "." + (self.databasemonth).to_s + "." + (self.databaseday).to_s
  end

  def get_record(ip)
    ipno = IPAddr.new(ip, Socket::AF_UNSPEC)
    self.ip_version = ipno.ipv4? ? 4 : 6
    self.v4 = ipno.ipv4?
    self.count = ipno.ipv4? ? self.ipv4databasecount + 0 : self.ipv6databasecount + 0
    self.base_addr = (ipno.ipv4? ? self.ipv4databaseaddr - 1 : self.ipv6databaseaddr - 1)

    ipnum = ipno.to_i + 0
    col_length = columns * 4

    if ipv4indexbaseaddr > 0 || ipv6indexbaseaddr > 0
        indexpos = 0
        case ip_version
        when 4
            ipnum1_2 = (ipnum >> 16)
            indexpos = ipv4indexbaseaddr + (ipnum1_2 << 3)
        when 6
            ipnum1 = (ipnum / (2**112))
            indexpos = ipv6indexbaseaddr + (ipnum1 << 3)
        end
        low = read32(indexpos)
        high = read32(indexpos + 4)
        return self.record = bsearch(low, high, ipnum, self.base_addr, col_length)
    else
        return self.record = bsearch(0, self.count, ipnum, self.base_addr, col_length)
    end
  end

  def get_country_short(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            country_short = (defined?(rec.country_short) && rec.country_short != '') ? rec.country_short : FIELD_NOT_SUPPORTED
        else
            country_short = INVALID_IP_ADDRESS
        end
    else
        country_short = INVALID_IP_ADDRESS
    end
    return country_short
  end

  def get_country_long(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            country_long = (defined?(rec.country_long) && rec.country_long != '') ? rec.country_long : FIELD_NOT_SUPPORTED
        else
            country_long = INVALID_IP_ADDRESS
        end
    else
        country_long = INVALID_IP_ADDRESS
    end
    return country_long
  end

  def get_region(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            region = (defined?(rec.region) && rec.region != '') ? rec.region : FIELD_NOT_SUPPORTED
        else
            region = INVALID_IP_ADDRESS
        end
    else
        region = INVALID_IP_ADDRESS
    end
    return region
  end

  def get_city(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            city = (defined?(rec.city) && rec.city != '') ? rec.city : FIELD_NOT_SUPPORTED
        else
            city = INVALID_IP_ADDRESS
        end
    else
        city = INVALID_IP_ADDRESS
    end
    return city
  end

  def get_isp(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            isp = (defined?(rec.isp) && rec.isp != '') ? rec.isp : FIELD_NOT_SUPPORTED
        else
            isp = INVALID_IP_ADDRESS
        end
    else
        isp = INVALID_IP_ADDRESS
    end
    return isp
  end

  def get_proxytype(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            proxytype = (defined?(rec.proxytype) && rec.proxytype != '') ? rec.proxytype : FIELD_NOT_SUPPORTED
        else
            proxytype = INVALID_IP_ADDRESS
        end
    else
        proxytype = INVALID_IP_ADDRESS
    end
    return proxytype
  end

  def get_domain(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            domain = (defined?(rec.domain) && rec.domain != '') ? rec.domain : FIELD_NOT_SUPPORTED
        else
            domain = INVALID_IP_ADDRESS
        end
    else
        domain = INVALID_IP_ADDRESS
    end
    return domain
  end

  def get_usagetype(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            usagetype = (defined?(rec.usagetype) && rec.usagetype != '') ? rec.usagetype : FIELD_NOT_SUPPORTED
        else
            usagetype = INVALID_IP_ADDRESS
        end
    else
        usagetype = INVALID_IP_ADDRESS
    end
    return usagetype
  end

  def get_asn(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            asn = (defined?(rec.asn) && rec.asn != '') ? rec.asn : FIELD_NOT_SUPPORTED
        else
            asn = INVALID_IP_ADDRESS
        end
    else
        asn = INVALID_IP_ADDRESS
    end
    return asn
  end

  def get_as(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            as = (defined?(rec.as) && rec.as != '') ? rec.as : FIELD_NOT_SUPPORTED
        else
            as = INVALID_IP_ADDRESS
        end
    else
        as = INVALID_IP_ADDRESS
    end
    return as
  end

  def get_last_seen(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            last_seen = (defined?(rec.lastseen) && rec.lastseen != '') ? rec.lastseen : FIELD_NOT_SUPPORTED
        else
            last_seen = INVALID_IP_ADDRESS
        end
    else
        last_seen = INVALID_IP_ADDRESS
    end
    return last_seen
  end

  def is_proxy(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            if self.db_index == 1
                isproxy = (rec.country_short == '-') ? 0 : 1
            else
                isproxy = (rec.proxytype == '-') ? 0 : (rec.proxytype == 'DCH' || rec.proxytype == 'SES') ? 2 : 1
            end
        else
            isproxy = -1
        end
    else
        isproxy = -1
    end
    return isproxy
  end

  def get_all(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            country_short = (defined?(rec.country_short) && rec.country_short != '') ? rec.country_short : FIELD_NOT_SUPPORTED
            country_long = (defined?(rec.country_long) && rec.country_long != '') ? rec.country_long : FIELD_NOT_SUPPORTED
            region = (defined?(rec.region) && rec.region != '') ? rec.region : FIELD_NOT_SUPPORTED
            city = (defined?(rec.city) && rec.city != '') ? rec.city : FIELD_NOT_SUPPORTED
            isp = (defined?(rec.isp) && rec.isp != '') ? rec.isp : FIELD_NOT_SUPPORTED
            proxytype = (defined?(rec.proxytype) && rec.proxytype != '') ? rec.proxytype : FIELD_NOT_SUPPORTED
            domain = (defined?(rec.domain) && rec.domain != '') ? rec.domain : FIELD_NOT_SUPPORTED
            usagetype = (defined?(rec.usagetype) && rec.usagetype != '') ? rec.usagetype : FIELD_NOT_SUPPORTED
            asn = (defined?(rec.asn) && rec.asn != '') ? rec.asn : FIELD_NOT_SUPPORTED
            as = (defined?(rec.as) && rec.as != '') ? rec.as : FIELD_NOT_SUPPORTED
            last_seen = (defined?(rec.lastseen) && rec.lastseen != '') ? rec.lastseen : FIELD_NOT_SUPPORTED

            if self.db_index == 1
                isproxy = (rec.country_short == '-') ? 0 : 1
            else
                isproxy = (rec.proxytype == '-') ? 0 : (rec.proxytype == 'DCH' || rec.proxytype == 'SES') ? 2 : 1
            end
        else
            country_short = INVALID_IP_ADDRESS
            country_long = INVALID_IP_ADDRESS
            region = INVALID_IP_ADDRESS
            city = INVALID_IP_ADDRESS
            isp = INVALID_IP_ADDRESS
            proxytype = INVALID_IP_ADDRESS
            domain = INVALID_IP_ADDRESS
            usagetype = INVALID_IP_ADDRESS
            asn = INVALID_IP_ADDRESS
            as = INVALID_IP_ADDRESS
            last_seen = INVALID_IP_ADDRESS
            isproxy = -1
        end
    else
        country_short = INVALID_IP_ADDRESS
        country_long = INVALID_IP_ADDRESS
        region = INVALID_IP_ADDRESS
        city = INVALID_IP_ADDRESS
        isp = INVALID_IP_ADDRESS
        proxytype = INVALID_IP_ADDRESS
        domain = INVALID_IP_ADDRESS
        usagetype = INVALID_IP_ADDRESS
        asn = INVALID_IP_ADDRESS
        as = INVALID_IP_ADDRESS
        last_seen = INVALID_IP_ADDRESS
        isproxy = -1
    end

    results = {}
    results['is_proxy'] = isproxy
    results['proxy_type'] = proxytype
    results['country_short'] = country_short
    results['country_long'] = country_long
    results['region'] = region
    results['city'] = city
    results['isp'] = isp
    results['domain'] = domain
    results['usagetype'] = usagetype
    results['asn'] = asn
    results['as'] = as
    results['last_seen'] = last_seen

    return results
  end

  def bsearch(low, high, ipnum, base_addr, col_length)
    while low <= high do
        mid = (low + high) >> 1
        ip_from, ip_to = get_from_to(mid, base_addr, col_length)
        if ipnum >= ip_from && ipnum < ip_to
            from_base = ( base_addr + mid * (col_length + (self.v4 ? 0 : 12)))
            file.seek(from_base)
            if v4
                return self.record_class4.read(file)
            else
                return self.record_class6.read(file)
            end
        else
            if ipnum < ip_from
                high = mid - 1
            else
                low = mid + 1
            end
        end
    end    
  end

  def get_from_to(mid, base_addr, col_length)
    from_base = ( base_addr + mid * (col_length + (v4 ? 0 : 12)))
    file.seek(from_base)
    ip_from = v4 ? file.read(4).unpack('V').first : readipv6(file)
    file.seek(from_base + col_length + (v4 ? 0 : 12))
    ip_to = v4 ? file.read(4).unpack('V').first : readipv6(file)
    [ip_from, ip_to]
  end

  def read32(indexp)
    file.seek(indexp - 1)
    return file.read(4).unpack('V').first
  end

  def readipv6(filer)
    parts = filer.read(16).unpack('V*')
    return parts[0] + parts[1] * 4294967296 + parts[2] * 4294967296**2 + parts[3] * 4294967296**3
  end

  private :get_record, :bsearch, :get_from_to, :read32, :readipv6

end
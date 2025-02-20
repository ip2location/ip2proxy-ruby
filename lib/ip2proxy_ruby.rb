require 'bindata'
require 'ipaddr'
require 'net/http'
require 'json'
require_relative 'ip2proxy_ruby/ip2proxy_config'
require_relative 'ip2proxy_ruby/i2p_database_config'
require_relative 'ip2proxy_ruby/i2p_string_data'
require_relative 'ip2proxy_ruby/i2p_ip_data'
require_relative 'ip2proxy_ruby/ip2proxy_record'

class Ip2proxy
  attr_accessor :record_class4, :record_class6, :v4, :file, :db_index, :count, :base_addr, :ipno, :record, :database, :columns, :ip_version, :ipv4databasecount, :ipv4databaseaddr, :ipv4indexbaseaddr, :ipv6databasecount, :ipv6databaseaddr, :ipv6indexbaseaddr, :databaseyear, :databasemonth, :databaseday, :last_err_msg

  VERSION = '3.4.0'
  FIELD_NOT_SUPPORTED = 'NOT SUPPORTED'
  INVALID_IP_ADDRESS = 'INVALID IP ADDRESS'
  INVALID_BIN_DATABASE = 'Incorrect IP2Proxy BIN file format. Please make sure that you are using the latest IP2Proxy BIN file.'

  def open(url)
    if url == ''
        self.last_err_msg = 'Ip2proxy.new.open() requires a database path name.'
        abort('Ip2proxy.new.open() requires a database path name.')
    end

    begin
        self.file = File.open(File.expand_path url, 'rb')
    rescue
        self.last_err_msg = 'Ip2proxy.new.open() error in opening ' + url +'.'
        abort('Ip2proxy.new.open() error in opening ' + url + '. No such file in the /your_ip2proxy_ruby_library_path/rb/ folder.')
    else
    end
    i2p = Ip2proxyConfig.read(file)
    if i2p.productcode == 2
    else
        if i2p.databaseyear <= 20 && i2p.productcode == 0
        else
            self.file.close
            self.last_err_msg = INVALID_BIN_DATABASE
            abort(INVALID_BIN_DATABASE)
        end
    end
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

  def get_last_error_message()
    return self.last_err_msg
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
    self.ip_version, ipnum = validateip(ipno)
    self.v4 = ip_version == 4 ? true : false
    self.count = v4 ? self.ipv4databasecount + 0 : self.ipv6databasecount + 0
    self.base_addr = (v4 ? self.ipv4databaseaddr - 1 : self.ipv6databaseaddr - 1)
    col_length = columns * 4
    if ipv4indexbaseaddr > 0 || ipv6indexbaseaddr > 0
        indexpos = 0
        case ip_version
        when 4
            indexpos = ipv4indexbaseaddr + ((ipnum >> 16) << 3)
            realipno = ipnum
            # if ipnum reach MAX_IPV4_RANGE
            if realipno == 4294967295
                ipnum = realipno - 1
            end
        when 6
            indexpos = ipv6indexbaseaddr + ((ipnum >> 112) << 3)
            realipno = ipnum
            # if ipnum reach MAX_IPV6_RANGE
            if realipno == 340282366920938463463374607431768211455
                ipnum = realipno - 1
            end
        end
        low, high = read32x2(indexpos)
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

  def get_threat(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            threat = (defined?(rec.threat) && rec.threat != '') ? rec.threat : FIELD_NOT_SUPPORTED
        else
            threat = INVALID_IP_ADDRESS
        end
    else
        threat = INVALID_IP_ADDRESS
    end
    return threat
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

  def get_provider(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            provider = (defined?(rec.provider) && rec.provider != '') ? rec.provider : FIELD_NOT_SUPPORTED
        else
            provider = INVALID_IP_ADDRESS
        end
    else
        provider = INVALID_IP_ADDRESS
    end
    return provider
  end

  def get_fraud_score(ip)
    valid = !(IPAddr.new(ip) rescue nil).nil?
    if valid
        rec = get_record(ip)
        if !(rec.nil?)
            fraud_score = (defined?(rec.fraud_score) && rec.fraud_score != '') ? rec.fraud_score : FIELD_NOT_SUPPORTED
        else
            fraud_score = INVALID_IP_ADDRESS
        end
    else
        fraud_score = INVALID_IP_ADDRESS
    end
    return fraud_score
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
            threat = (defined?(rec.threat) && rec.threat != '') ? rec.threat : FIELD_NOT_SUPPORTED
            provider = (defined?(rec.provider) && rec.provider != '') ? rec.provider : FIELD_NOT_SUPPORTED
            fraud_score = (defined?(rec.fraud_score) && rec.fraud_score != '') ? rec.fraud_score : FIELD_NOT_SUPPORTED
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
            threat = INVALID_IP_ADDRESS
            provider = INVALID_IP_ADDRESS
            fraud_score = INVALID_IP_ADDRESS
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
        threat = INVALID_IP_ADDRESS
        provider = INVALID_IP_ADDRESS
        fraud_score = INVALID_IP_ADDRESS
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
    results['threat'] = threat
    results['provider'] = provider
    results['fraud_score'] = fraud_score
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
    from_base = (base_addr + mid * (col_length + (v4 ? 0 : 12)))
    data_length = col_length + (v4 ? 4 : (12 + 16))
    file.seek(from_base)
    data_read = file.read(data_length)
    ip_from = v4 ? data_read[0..3].unpack('V').first : readipv6(data_read[0..15].unpack('V*'))
    ip_to = v4 ? data_read[(data_length - 4)..(data_length - 1)].unpack('V').first : readipv6(data_read[(data_length - 16)..(data_length - 1)].unpack('V*'))
    [ip_from, ip_to]
  end

  def validateip(ip)
    if ip.ipv4?
        ipv = 4
        ipnum = ip.to_i + 0
    else
        ipv = 6
        ipnum = ip.to_i + 0
        #reformat ipv4 address in ipv6 
        if ipnum >= 281470681743360 && ipnum <= 281474976710655
            ipv = 4
            ipnum = ipnum - 281470681743360
        end
        #reformat 6to4 address to ipv4 address 2002:: to 2002:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF
        if ipnum >= 42545680458834377588178886921629466624 && ipnum <= 42550872755692912415807417417958686719
            ipv = 4
            #bitshift right 80 bits
            ipnum = ipnum >> 80
            #bitwise modulus to get the last 32 bit
            ipnum = ipnum % 4294967296
        end
        #reformat Teredo address to ipv4 address 2001:0000:: to 2001:0000:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:
        if ipnum >= 42540488161975842760550356425300246528 && ipnum <= 42540488241204005274814694018844196863
            ipv = 4
            #bitwise not to invert binary
            ipnum = ~ipnum
            #bitwise modulus to get the last 32 bit
            ipnum = ipnum % 4294967296
        end
    end
    [ipv, ipnum]
  end

  def read32x2(indexp)
    file.seek(indexp - 1)
    data_read = file.read(8)
    data1 = data_read[0..3].unpack('V').first
    data2 = data_read[4..7].unpack('V').first
    return [data1, data2]
  end

  def readipv6(parts)
    return parts[0] + parts[1] * 4294967296 + parts[2] * 4294967296**2 + parts[3] * 4294967296**3
  end

  private :get_record, :bsearch, :get_from_to, :read32x2, :readipv6

end

class Ip2proxyWebService
  attr_accessor :ws_api_key, :ws_package, :ws_use_ssl

  def initialize(api_key, package, use_ssl)
    if !api_key.match(/^[0-9A-Z]{10}$/) && api_key != 'demo'
      raise Exception.new "Please provide a valid IP2Proxy web service API key."
    end
    if !package.match(/^PX[0-9]+$/)
      package = 'PX1'
    end
    if use_ssl == ''
      use_ssl = true
    end
    self.ws_api_key = api_key
    self.ws_package = package
    self.ws_use_ssl = use_ssl
  end

  def lookup(ip)
    if self.ws_use_ssl
      response =  Net::HTTP.get(URI("https://api.ip2proxy.com/?key=" + self.ws_api_key + "&ip=" + ip + "&package=" + self.ws_package + "&format=json"))
    else
      response =  Net::HTTP.get(URI("http://api.ip2proxy.com/?key=" + self.ws_api_key + "&ip=" + ip + "&package=" + self.ws_package + "&format=json"))
    end
    parsed_response = JSON.parse(response)
    if parsed_response.nil?
      return false
    end
    if parsed_response["response"] != "OK"
      raise Exception.new "Error: " + parsed_response["response"]
    end
    return parsed_response
  end

  def get_credit()
    if self.ws_use_ssl
      response =  Net::HTTP.get(URI("https://api.ip2proxy.com/?key=" + self.ws_api_key + "&check=true"))
    else
      response =  Net::HTTP.get(URI("http://api.ip2proxy.com/?key=" + self.ws_api_key + "&check=true"))
    end
    parsed_response = JSON.parse(response)
    if parsed_response.nil?
      return 0
    end
    if parsed_response["response"].nil?
      return 0
    end
    return parsed_response["response"]
  end
end
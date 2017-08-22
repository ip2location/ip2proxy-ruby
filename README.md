# IP2Proxy Ruby Library

This module allows user to query an IP address if it was being used as open proxy, web proxy, VPN anonymizer and TOR exits. It lookup the proxy IP address from **IP2Proxy BIN Data** file. This data file can be downloaded at

* Free IP2Proxy BIN Data: http://lite.ip2location.com
* Commercial IP2Proxy BIN Data: http://www.ip2location.com/proxy-database


For more details, please visit:
[https://www.ip2location.com/ip2proxy/developers/ruby](https://www.ip2location.com/ip2proxy/developers/ruby)

## Methods

Below are the methods supported in this module.

|Method Name|Description|
|---|---|
|open|Open the IP2Proxy BIN data with **File I/O** mode for lookup.|
|close|Close and clean up the file pointer.|
|getPackageVersion|Get the package version (1 to 4 for PX1 to PX4 respectively).|
|getModuleVersion|Get the module version.|
|getDatabaseVersion|Get the database version.|
|isProxy|Check whether if an IP address was a proxy. Returned value:<ul><li>-1 : errors</li><li>0 : not a proxy</li><li>1 : a proxy</li><li>2 : a data center IP address</li></ul>|
|getAll|Return the proxy information in array.|
|getProxyType|Return the proxy type. Please visit <a href="https://www.ip2location.com/databases/px4-ip-proxytype-country-region-city-isp" target="_blank">IP2Location</a> for the list of proxy types supported|
|getCountryShort|Return the ISO3166-1 country code (2-digits) of the proxy.|
|getCountryLong|Return the ISO3166-1 country name of the proxy.|
|getRegion|Return the ISO3166-2 region name of the proxy. Please visit <a href="https://www.ip2location.com/free/iso3166-2" target="_blank">ISO3166-2 Subdivision Code</a> for the information of ISO3166-2 supported|
|getCity|Return the city name of the proxy.|
|getISP|Return the ISP name of the proxy.|

## Usage

```
require 'ip2proxy_ruby'

# open IP2Proxy BIN database for proxy lookup
i2p = Ip2proxy.new.open("./data/IP2PROXY-IP-PROXYTYPE-COUNTRY-REGION-CITY-ISP.SAMPLE.BIN")

# get versioning information
print 'Module Version: ' + i2p.getModuleVersion + "\n"
print 'Package Version: ' + i2p.getPackageVersion + "\n"
print 'Database Version: ' + i2p.getDatabaseVersion + "\n"

# individual proxy data check
print 'Is Proxy: ' + i2p.isProxy('4.0.0.47').to_s + "\n"
print 'Proxy Type: ' + i2p.getProxyType('4.0.0.47') + "\n"
print 'Country Code: ' + i2p.getCountryShort('4.0.0.47') + "\n"
print 'Country Name: ' + i2p.getCountryLong('4.0.0.47') + "\n"
print 'Region Name: ' + i2p.getRegion('4.0.0.47') + "\n"
print 'City Name: ' + i2p.getCity('4.0.0.47') + "\n"
print 'ISP: ' + i2p.getISP('4.0.0.47') + "\n"

# single function to get all proxy data returned in array
record = i2p.getAll('4.0.0.47')
print 'is Proxy: ' + record['is_proxy'].to_s + "\n"
print 'Proxy Type: ' + record['proxy_type'] + "\n"
print 'Country Code: ' + record['country_short'] + "\n"
print 'Country Name: ' + record['country_long'] + "\n"
print 'Region Name: ' + record['region'] + "\n"
print 'City Name: ' + record['city'] + "\n"
print 'ISP: ' + record['isp'] + "\n"

# close IP2Proxy BIN database
i2p.close()
```

## Support

Email: support@ip2location.com  
URL: [http://www.ip2location.com](http://www.ip2location.com)

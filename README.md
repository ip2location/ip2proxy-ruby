# IP2Proxy Ruby Library

This module allows user to query an IP address if it was being used as open proxy, web proxy, VPN anonymizer and TOR exits. It lookup the proxy IP address from **IP2Proxy BIN Data** file. This data file can be downloaded at

* Free IP2Proxy BIN Data: https://lite.ip2location.com
* Commercial IP2Proxy BIN Data: https://www.ip2location.com/proxy-database


For more details, please visit:
[https://www.ip2location.com/ip2proxy/developers/ruby](https://www.ip2location.com/ip2proxy/developers/ruby)

## Methods

Below are the methods supported in this module.

|Method Name|Description|
|---|---|
|open|Open the IP2Proxy BIN data with **File I/O** mode for lookup.|
|close|Close and clean up the file pointer.|
|get_package_version|Get the package version (1 to 4 for PX1 to PX4 respectively).|
|get_module_version|Get the module version.|
|get_database_version|Get the database version.|
|is_proxy|Check whether if an IP address was a proxy. Returned value:<ul><li>-1 : errors</li><li>0 : not a proxy</li><li>1 : a proxy</li><li>2 : a data center IP address</li></ul>|
|get_all|Return the proxy information in array.|
|get_proxytype|Return the proxy type. Please visit <a href="https://www.ip2location.com/databases/px4-ip-proxytype-country-region-city-isp" target="_blank">IP2Location</a> for the list of proxy types supported|
|get_country_short|Return the ISO3166-1 country code (2-digits) of the proxy.|
|get_country_long|Return the ISO3166-1 country name of the proxy.|
|get_region|Return the ISO3166-2 region name of the proxy. Please visit <a href="https://www.ip2location.com/free/iso3166-2" target="_blank">ISO3166-2 Subdivision Code</a> for the information of ISO3166-2 supported|
|get_city|Return the city name of the proxy.|
|get_isp|Return the ISP name of the proxy.|

## Usage

```
require 'ip2proxy_ruby'

# open IP2Proxy BIN database for proxy lookup
i2p = Ip2proxy.new.open("./data/IP2PROXY-IP-PROXYTYPE-COUNTRY-REGION-CITY-ISP.SAMPLE.BIN")

# get versioning information
print 'Module Version: ' + i2p.get_module_version + "\n"
print 'Package Version: ' + i2p.get_package_version + "\n"
print 'Database Version: ' + i2p.get_database_version + "\n"

# individual proxy data check
print 'Is Proxy: ' + i2p.is_proxy('4.0.0.47').to_s + "\n"
print 'Proxy Type: ' + i2p.get_proxytype('4.0.0.47') + "\n"
print 'Country Code: ' + i2p.get_country_short('4.0.0.47') + "\n"
print 'Country Name: ' + i2p.get_country_long('4.0.0.47') + "\n"
print 'Region Name: ' + i2p.get_region('4.0.0.47') + "\n"
print 'City Name: ' + i2p.get_city('4.0.0.47') + "\n"
print 'ISP: ' + i2p.get_isp('4.0.0.47') + "\n"

# single function to get all proxy data returned in array
record = i2p.get_all('4.0.0.47')
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
URL: [https://www.ip2location.com](https://www.ip2location.com)

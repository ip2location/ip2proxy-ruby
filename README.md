[![Latest Stable Version](https://img.shields.io/gem/v/ip2proxy_ruby.svg)](https://rubygems.org/gems/ip2proxy_ruby)
[![Total Downloads](https://img.shields.io/gem/dt/ip2proxy_ruby.svg)](https://rubygems.org/gems/ip2proxy_ruby)

# IP2Proxy Ruby Library

This module allows user to reverse search of IP address to detect VPN servers, open proxies, web proxies, Tor exit nodes, search engine robots, data center ranges and residential proxies using IP2Proxy BIN database. Other information available includes proxy type, country, state, city,  ISP, domain name, usage type, AS number, AS name, threats and last seen date.

It lookup the proxy IP address from **IP2Proxy BIN Data** file. This data file can be downloaded at

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
|get_package_version|Get the package version (1 to 10 for PX1 to PX10 respectively).|
|get_module_version|Get the module version.|
|get_database_version|Get the database version.|
|is_proxy|Check whether if an IP address was a proxy. Please see [Proxy Type](#proxy-type) for details. Returned value:<ul><li>-1 : errors</li><li>0 : not a proxy</li><li>1 : a proxy</li><li>2 : a data center IP address</li></ul>|
|get_all|Return the proxy information in array.|
|get_proxytype|Return the proxy type. Please visit <a href="https://www.ip2location.com/database/px10-ip-proxytype-country-region-city-isp-domain-usagetype-asn-lastseen-threat-residential" target="_blank">IP2Location</a> for the list of proxy types supported|
|get_country_short|Return the ISO3166-1 country code (2-digits) of the proxy.|
|get_country_long|Return the ISO3166-1 country name of the proxy.|
|get_region|Return the ISO3166-2 region name of the proxy. Please visit <a href="https://www.ip2location.com/free/iso3166-2" target="_blank">ISO3166-2 Subdivision Code</a> for the information of ISO3166-2 supported|
|get_city|Return the city name of the proxy.|
|get_isp|Return the ISP name of the proxy.|
|get_domain|Return the domain name of proxy's IP address or domain name.|
|get_usagetype|Return the ISP's usage type of proxy's IP address or domain name. Please see [Usage Type](#usage-type) for details.|
|get_asn|Return the autonomous system number (ASN) of proxy's IP address or domain name.|
|get_as|Return the autonomous system (AS) name of proxy's IP address or domain name.|
|get_last_seen|Return the last seen days ago value of proxy's IP address or domain name.|
|get_threat|Return the threat types reported to proxy's IP address or domain name. Please see [Threat Type](#threat-type) for details.|

## Usage

```
require 'ip2proxy_ruby'

# open IP2Proxy BIN database for proxy lookup
i2p = Ip2proxy.new.open("./data/IP2PROXY-IP-PROXYTYPE-COUNTRY-REGION-CITY-ISP-DOMAIN-USAGETYPE-ASN-LASTSEEN-THREAT-RESIDENTIAL.BIN")

# get versioning information
print 'Module Version: ' + i2p.get_module_version + "\n"
print 'Package Version: ' + i2p.get_package_version + "\n"
print 'Database Version: ' + i2p.get_database_version + "\n"

# individual proxy data check
print 'Is Proxy: ' + i2p.is_proxy('1.2.3.4').to_s + "\n"
print 'Proxy Type: ' + i2p.get_proxytype('1.2.3.4') + "\n"
print 'Country Code: ' + i2p.get_country_short('1.2.3.4') + "\n"
print 'Country Name: ' + i2p.get_country_long('1.2.3.4') + "\n"
print 'Region Name: ' + i2p.get_region('1.2.3.4') + "\n"
print 'City Name: ' + i2p.get_city('1.2.3.4') + "\n"
print 'ISP: ' + i2p.get_isp('1.2.3.4') + "\n"
print 'Domain: ' + i2p.get_domain('1.2.3.4') + "\n"
print 'Usage Type: ' + i2p.get_usagetype('1.2.3.4') + "\n"
print 'ASN: ' + i2p.get_asn('1.2.3.4') + "\n"
print 'AS: ' + i2p.get_as('1.2.3.4') + "\n"
print 'Last Seen: ' + i2p.get_last_seen('1.2.3.4') + "\n"
print 'Threat: ' + i2p.get_threat('1.2.3.4') + "\n"

# single function to get all proxy data returned in array
record = i2p.get_all('1.2.3.4')
print 'is Proxy: ' + record['is_proxy'].to_s + "\n"
print 'Proxy Type: ' + record['proxy_type'] + "\n"
print 'Country Code: ' + record['country_short'] + "\n"
print 'Country Name: ' + record['country_long'] + "\n"
print 'Region Name: ' + record['region'] + "\n"
print 'City Name: ' + record['city'] + "\n"
print 'ISP: ' + record['isp'] + "\n"
print 'Domain: ' + record['domain'] + "\n"
print 'Usage Type: ' + record['usagetype'] + "\n"
print 'ASN: ' + record['asn'] + "\n"
print 'AS: ' + record['as'] + "\n"
print 'Last Seen: ' + record['last_seen'] + "\n"
print 'Threat: ' + record['threat'] + "\n"

# close IP2Proxy BIN database
i2p.close()
```

### Proxy Type

|Proxy Type|Description|
|---|---|
|VPN|Anonymizing VPN services|
|TOR|Tor Exit Nodes|
|PUB|Public Proxies|
|WEB|Web Proxies|
|DCH|Hosting Providers/Data Center|
|SES|Search Engine Robots|
|RES|Residential Proxies [PX10+]|

### Usage Type

|Usage Type|Description|
|---|---|
|COM|Commercial|
|ORG|Organization|
|GOV|Government|
|MIL|Military|
|EDU|University/College/School|
|LIB|Library|
|CDN|Content Delivery Network|
|ISP|Fixed Line ISP|
|MOB|Mobile ISP|
|DCH|Data Center/Web Hosting/Transit|
|SES|Search Engine Spider|
|RSV|Reserved|

### Threat Type

|Threat Type|Description|
|---|---|
|SPAM|Spammer|
|SCANNER|Security Scanner or Attack|
|BOTNET|Spyware or Malware|

## Support

Email: support@ip2location.com  
URL: [https://www.ip2location.com](https://www.ip2location.com)

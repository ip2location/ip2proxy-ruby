[![Latest Stable Version](https://img.shields.io/gem/v/ip2proxy_ruby.svg)](https://rubygems.org/gems/ip2proxy_ruby)
[![Total Downloads](https://img.shields.io/gem/dt/ip2proxy_ruby.svg)](https://rubygems.org/gems/ip2proxy_ruby)

# IP2Proxy Ruby Library
This module allows user to reverse search of IP address to detect VPN servers, open proxies, web proxies, Tor exit nodes, search engine robots, data center ranges and residential proxies using IP2Proxy BIN database. Other information available includes proxy type, country, state, city,  ISP, domain name, usage type, AS number, AS name, threats, last seen date and provider names. It lookup the proxy IP address from **IP2Proxy BIN Data** file or web service.

For more details, please visit:
[https://www.ip2location.com/ip2proxy/developers/ruby](https://www.ip2location.com/ip2proxy/developers/ruby)

# Usage
You can check the **example.rb** file to learn more about usage.

## BIN Database
Below is the description of the functions available in the **BIN Database** lookup.

|Method Name|Description|
|---|---|
|open|Open the IP2Proxy BIN data with **File I/O** mode for lookup.|
|close|Close and clean up the file pointer.|
|get_package_version|Get the package version (1 to 11 for PX1 to PX11 respectively).|
|get_module_version|Get the module version.|
|get_database_version|Get the database version.|
|is_proxy|Check whether if an IP address was a proxy. Please see [Proxy Type](#proxy-type) for details. Returned value:<ul><li>-1 : errors</li><li>0 : not a proxy</li><li>1 : a proxy</li><li>2 : a data center IP address</li></ul>|
|get_all|Return the proxy information in array.|
|get_proxytype|Return the proxy type. Please visit <a href="https://www.ip2location.com/database/px11-ip-proxytype-country-region-city-isp-domain-usagetype-asn-lastseen-threat-residential-provider" target="_blank">IP2Location</a> for the list of proxy types supported|
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
|get_provider|Returns the VPN service provider name if available.|

## Web Service
Below is the description of the functions available in the **Web Service** lookup.

| Function Name | Description |
|---|---|
| Constructor | Expect 3 input parameters:<ol><li>IP2Proxy API Key.</li><li>Package (PX1 - PX11)</li></li><li>Use HTTPS or HTTP</li></ol> |
| lookup | Return the proxy information in array.<ul><li>countryCode</li><li>countryName</li><li>regionName</li><li>cityName</li><li>isp</li><li>domain</li><li>usageType</li><li>asn</li><li>as</li><li>lastSeen</li><li>threat</li><li>proxyType</li><li>isProxy</li><li>provider</li><ul> |
| get_credit | Return remaining credit of the web service account. |

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

# Dependencies

This library requires IP2Proxy BIN data file to function. You may download the BIN data file at
* IP2Proxy LITE BIN Data (Free): https://lite.ip2location.com
* IP2Proxy Commercial BIN Data (Comprehensive): https://www.ip2location.com/proxy-database

An outdated BIN database was provided in the library for your testing. You are recommended to visit the above links to download the latest BIN database.

You can also sign up for [IP2Proxy Web Service](https://www.ip2location.com/web-service/ip2proxy) to lookup by IP2Proxy API.

# Support

Email: support@ip2location.com  
URL: [https://www.ip2location.com](https://www.ip2location.com)

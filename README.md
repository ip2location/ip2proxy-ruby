[![Latest Stable Version](https://img.shields.io/gem/v/ip2proxy_ruby.svg)](https://rubygems.org/gems/ip2proxy_ruby)
[![Total Downloads](https://img.shields.io/gem/dt/ip2proxy_ruby.svg)](https://rubygems.org/gems/ip2proxy_ruby)

# IP2Proxy Ruby Library
This module allows user to reverse search of IP address to detect VPN servers, open proxies, web proxies, Tor exit nodes, search engine robots, data center ranges, residential proxies, consumer privacy networks, and enterprise private networks using IP2Proxy BIN database. Other information available includes proxy type, country, state, city,  ISP, domain name, usage type, AS number, AS name, threats, last seen date and provider names. It lookup the proxy IP address from **IP2Proxy BIN Data** file or web service.

For more details, please visit:
[https://www.ip2location.com/ip2proxy/developers/ruby](https://www.ip2location.com/ip2proxy/developers/ruby)

# Developer Documentation
To learn more about installation, usage, and code examples, please visit the developer documentation at [https://ip2proxy-ruby.readthedocs.io/en/latest/index.html.](https://ip2proxy-ruby.readthedocs.io/en/latest/index.html)


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
|CPN|Consumer Privacy Networks. [PX11+]|
|EPN|Enterprise Private Networks. [PX11+]|

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

You can also sign up for [IP2Proxy Web Service](https://www.ip2location.com/web-service/ip2proxy) to lookup by IP2Proxy API.

# Support

Email: support@ip2location.com  
URL: [https://www.ip2location.com](https://www.ip2location.com)

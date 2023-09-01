# Quickstart

## Dependencies

This library requires IP2Proxy BIN database to function. You may download the BIN database at

-   IP2Proxy LITE BIN Data (Free): <https://lite.ip2location.com>
-   IP2Proxy Commercial BIN Data (Comprehensive):
    <https://www.ip2location.com>

:::{note}
An outdated BIN database was provided in the data folder for your testing. You are recommended to visit the above links to download the latest BIN database.
:::

## Installation

Install this package using the command as below:

```
gem install ip2proxy_ruby
```

## Sample Codes

### Query geolocation information from BIN database

You can query the geolocation information from the IP2Proxy BIN database as below:

```ruby
require 'ip2proxy_ruby'

# open IP2Proxy BIN database for proxy lookup
i2p = Ip2proxy.new.open("./data/PX11.SAMPLE.BIN")

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
print 'Provider: ' + i2p.get_provider('1.2.3.4') + "\n"

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
print 'Provider: ' + record['provider'] + "\n"

# close IP2Proxy BIN database
i2p.close()
```
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
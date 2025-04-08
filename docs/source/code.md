# IP2Proxy Ruby API

## Database Class
```{py:function} open(database_file_path)
Load the IP2Proxy BIN database.

:param str database_file_path: (Required) The file path links to IP2Location BIN databases.
```

```{py:function} get_package_version()
Return the database's type, 1 to 12 respectively for PX1 to PX12. Please visit https://www.ip2location.com/databases/ip2proxy for details.

:return: Returns the package version.
:rtype: string
```

```{py:function} get_module_version()
Return the version of module.

:return: Returns the module version.
:rtype: string
```

```{py:function} get_database_version()
Return the database's compilation date as a string of the form 'YYYY-MM-DD'.

:return: Returns the database version.
:rtype: string
```

```{py:function} get_all(ip_address)
Retrieve geolocation information for an IP address.

:param str ip_address: (Required) The IP address (IPv4 or IPv6).
:return: Returns the geolocation information in array. Refer below table for the fields avaliable in the array
:rtype: array

**RETURN FIELDS**

| Field Name       | Description                                                  |
| ---------------- | ------------------------------------------------------------ |
| is_proxy         |     Determine whether if an IP address was a proxy or not. Returns 0 is not proxy, 1 if proxy, and 2 if it's data center IP |
| country_short    |     Two-character country code based on ISO 3166. |
| country_long     |     Country name based on ISO 3166. |
| region           |     Region or state name. |
| city             |     City name. |
| isp              |     Internet Service Provider or company\'s name. |
| domain           |     Internet domain name associated with IP address range. |
| usagetype        |     Usage type classification of ISP or company. |
| asn              |     Autonomous system number (ASN). |
| as               |     Autonomous system (AS) name. |
| last_seen        |     Proxy last seen in days. |
| threat           |     Security threat reported. |
| is_proxy         |     Type of proxy. |
| provider         |     Name of VPN provider if available. |
| fraud_score      |     Potential risk score (0 - 99) associated with IP address. |
```
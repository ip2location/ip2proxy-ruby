class I2pDbConfig 
  COLUMNS = { 
     :COUNTRY                  => [0, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3],
     :REGION                   => [0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4],
     :CITY                     => [0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5],
     :ISP                      => [0, 0, 0, 0, 6, 6, 6, 6, 6, 6, 6, 6],
     :PROXYTYPE                => [0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
     :DOMAIN                   => [0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7, 7],
     :USAGETYPE                => [0, 0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 8],
     :ASN                      => [0, 0, 0, 0, 0, 0, 0, 9, 9, 9, 9, 9],
     :AS                       => [0, 0, 0, 0, 0, 0, 0, 10, 10, 10, 10, 10],
     :LASTSEEN                 => [0, 0, 0, 0, 0, 0, 0, 0, 11, 11, 11, 11],
     :THREAT                   => [0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 12, 12],
     :PROVIDER                 => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13]
   }
   
 def self.setup_database(db_index)
   # strip all 0 value & downcase keys
  cols = COLUMNS.inject({}) {|memo, (key, value)|
   (memo[key.to_s.downcase.to_sym] = value[db_index] if value[db_index] > 0)
   memo
  }
  # order by value
  col_array = cols.sort_by {|key,value| value}
 end
 
end
 
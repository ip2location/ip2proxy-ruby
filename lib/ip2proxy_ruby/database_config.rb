class DbConfig 
  COLUMNS = { 
     :COUNTRY                  => [0, 2, 3, 3, 3],
     :REGION                   => [0, 0, 0, 4, 4],
     :CITY                     => [0, 0, 0, 5, 5],
     :ISP                      => [0, 0, 0, 0, 6],
     :PROXYTYPE                => [0, 0, 2, 2, 2]
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
 
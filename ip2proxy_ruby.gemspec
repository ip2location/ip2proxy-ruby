# coding: utf-8

Gem::Specification.new do |s|
  s.name          = "ip2proxy_ruby"
  s.version       = "1.0.3"
  s.authors       = ["ip2location"]
  s.email         = ["support@ip2location.com"]

  s.summary       = "IP2Proxy Ruby library"
  s.description   = "Ruby library for IP2Proxy"
  s.homepage      = "https://github.com/ip2location/ip2proxy-ruby"
  s.licenses      = ["MIT"]
  s.require_paths = ["lib"]
  
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".gitignore",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "ip2proxy_ruby.gemspec",
    "example.rb",
    "lib/ip2proxy_ruby.rb",
    "lib/ip2proxy_ruby/i2p_database_config.rb",
    "lib/ip2proxy_ruby/i2p_ip_data.rb",
    "lib/ip2proxy_ruby/i2p_string_data.rb",
    "lib/ip2proxy_ruby/ip2proxy_config.rb",
    "lib/ip2proxy_ruby/ip2proxy_record.rb",
    "spec/assets/IP2PROXY-IP-PROXYTYPE-COUNTRY-REGION-CITY-ISP.SAMPLE.BIN",
    "spec/ip2proxy_ruby_spec.rb",
    "spec/spec_helper.rb",
    "rb/data/IP2PROXY-IP-PROXYTYPE-COUNTRY-REGION-CITY-ISP.SAMPLE.BIN"
  ]
  
  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bindata>, [">= 0"])
      s.add_development_dependency(%q<awesome_print>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, [">= 1.2.0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<bindata>, [">= 0"])
      s.add_dependency(%q<awesome_print>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, [">= 1.2.0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<bindata>, [">= 0"])
    s.add_dependency(%q<awesome_print>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, [">= 1.2.0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end

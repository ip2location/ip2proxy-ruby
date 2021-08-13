# coding: utf-8

Gem::Specification.new do |s|
  s.name          = "ip2proxy_ruby"
  s.version       = "3.2.0"
  s.authors       = ["ip2location"]
  s.email         = ["support@ip2location.com"]

  s.summary       = "IP2Proxy Ruby library"
  s.description   = "The official IP2Proxy Ruby library to detect VPN servers, open proxies, web proxies, Tor exit nodes, search engine robots, data center ranges and residential proxies using IP2Proxy BIN database. Other information available includes proxy type, country, state, city, ISP, domain name, usage type, AS number, AS name, threats, last seen date and provider names."
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
    "spec/assets/PX11.SAMPLE.BIN",
    "spec/ip2proxy_ruby_database_spec.rb",
    "spec/spec_helper.rb",
    "rb/data/PX11.SAMPLE.BIN"
  ]

  if s.respond_to?(:metadata=)
    s.metadata = {
      "bug_tracker_uri" => "https://github.com/ip2location/ip2proxy-ruby/issues",
      "homepage_uri" => "https://www.ip2location.com",
      "source_code_uri" => "https://github.com/ip2location/ip2proxy-ruby",
    }
  end

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bindata>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, [">= 1.2.0"])
    else
      s.add_dependency(%q<bindata>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, [">= 1.2.0"])
    end
  else
    s.add_dependency(%q<bindata>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, [">= 1.2.0"])
  end
end

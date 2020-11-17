# -*- encoding: utf-8 -*-
# stub: omniauth-instagram-graph 1.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-instagram-graph".freeze
  s.version = "1.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "homepage_uri" => "http://github.com/jetrockets/omniauth-instagram-graph", "source_code_uri" => "http://github.com/jetrockets/omniauth-instagram-graph" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Igor Alexandrov".freeze]
  s.date = "2020-06-03"
  s.email = ["igor.alexandrov@gmail.com".freeze]
  s.executables = ["console".freeze, "setup".freeze]
  s.files = ["bin/console".freeze, "bin/setup".freeze]
  s.homepage = "http://github.com/jetrockets/omniauth-instagram-graph".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "instagram Graph OAuth2 Strategy for OmniAuth".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth>.freeze, ["~> 1.9"])
      s.add_runtime_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<jetrockets-standard>.freeze, [">= 0"])
    else
      s.add_dependency(%q<omniauth>.freeze, ["~> 1.9"])
      s.add_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.2"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
      s.add_dependency(%q<mocha>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<jetrockets-standard>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<omniauth>.freeze, ["~> 1.9"])
    s.add_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.2"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
    s.add_dependency(%q<mocha>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<jetrockets-standard>.freeze, [">= 0"])
  end
end

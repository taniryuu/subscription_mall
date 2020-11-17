# -*- encoding: utf-8 -*-
# stub: omniauth-line-oauth2 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-line-oauth2".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["nguyenthanhcong101096".freeze]
  s.bindir = "exe".freeze
  s.date = "2019-09-11"
  s.description = "OmniAuth strategy for Line".freeze
  s.email = ["nguyenthanhcong101096@gmail.com".freeze]
  s.homepage = "https://github.com/arunagw/omniauth-twitter".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "OmniAuth strategy for Line".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth>.freeze, [">= 1.1.1"])
      s.add_runtime_dependency(%q<omniauth-oauth2>.freeze, [">= 1.6"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.6"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.49"])
    else
      s.add_dependency(%q<omniauth>.freeze, [">= 1.1.1"])
      s.add_dependency(%q<omniauth-oauth2>.freeze, [">= 1.6"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.6"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.49"])
    end
  else
    s.add_dependency(%q<omniauth>.freeze, [">= 1.1.1"])
    s.add_dependency(%q<omniauth-oauth2>.freeze, [">= 1.6"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.6"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.49"])
  end
end

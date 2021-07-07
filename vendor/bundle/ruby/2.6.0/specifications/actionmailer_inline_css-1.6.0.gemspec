# -*- encoding: utf-8 -*-
# stub: actionmailer_inline_css 1.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "actionmailer_inline_css".freeze
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Nathan Broadbent".freeze]
  s.date = "2017-10-10"
  s.description = "Module for ActionMailer to improve the rendering of HTML emails by using the 'premailer' gem, which inlines CSS and makes relative links absolute.".freeze
  s.email = "nathan.f77@gmail.com".freeze
  s.homepage = "http://premailer.dialect.ca/".freeze
  s.rubygems_version = "3.0.8".freeze
  s.summary = "Always send HTML e-mails with inline CSS, using the 'premailer' gem".freeze

  s.installed_by_version = "3.0.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionmailer>.freeze, [">= 3.0.0"])
      s.add_runtime_dependency(%q<premailer>.freeze, [">= 1.11.0"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 1.7.0"])
      s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
      s.add_development_dependency(%q<mocha>.freeze, [">= 0.10.0"])
    else
      s.add_dependency(%q<actionmailer>.freeze, [">= 3.0.0"])
      s.add_dependency(%q<premailer>.freeze, [">= 1.11.0"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 1.7.0"])
      s.add_dependency(%q<test-unit>.freeze, [">= 0"])
      s.add_dependency(%q<mocha>.freeze, [">= 0.10.0"])
    end
  else
    s.add_dependency(%q<actionmailer>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<premailer>.freeze, [">= 1.11.0"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 1.7.0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<mocha>.freeze, [">= 0.10.0"])
  end
end

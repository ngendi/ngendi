# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{geokit-rails3}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andre Lewis", "Bill Eisenhauer", "Jeremy Lecour"]
  s.date = %q{2010-10-17}
  s.description = %q{Port of the Rails plugin "geokit-rails" to Rails 3, as a gem}
  s.email = ["andre@earthcode.com", "bill_eisenhauer@yahoo.com", "jeremy.lecour@gmail.com"]
  s.files = ["lib/geokit-rails3/acts_as_mappable.old.rb", "lib/geokit-rails3/acts_as_mappable.rb", "lib/geokit-rails3/adapters/abstract.rb", "lib/geokit-rails3/adapters/mysql.rb", "lib/geokit-rails3/adapters/mysql2.rb", "lib/geokit-rails3/adapters/postgresql.rb", "lib/geokit-rails3/adapters/sqlserver.rb", "lib/geokit-rails3/core_extensions.rb", "lib/geokit-rails3/defaults.rb", "lib/geokit-rails3/geocoder_control.rb", "lib/geokit-rails3/ip_geocode_lookup.rb", "lib/geokit-rails3/railtie.rb", "lib/geokit-rails3/version.rb", "lib/geokit-rails3.rb", "test/acts_as_mappable_test.rb", "test/boot.rb", "test/database.yml", "test/fixtures/companies.yml", "test/fixtures/custom_locations.yml", "test/fixtures/locations.yml", "test/fixtures/mock_addresses.yml", "test/fixtures/mock_families.yml", "test/fixtures/mock_houses.yml", "test/fixtures/mock_organizations.yml", "test/fixtures/mock_people.yml", "test/fixtures/stores.yml", "test/models/company.rb", "test/models/custom_location.rb", "test/models/location.rb", "test/models/mock_address.rb", "test/models/mock_family.rb", "test/models/mock_house.rb", "test/models/mock_organization.rb", "test/models/mock_person.rb", "test/models/store.rb", "test/mysql-debug.log", "test/schema.rb", "test/tasks.rake", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/jlecour/geokit-rails3}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Integrate Geokit with Rails 3}
  s.test_files = ["test/acts_as_mappable_test.rb", "test/boot.rb", "test/database.yml", "test/fixtures/companies.yml", "test/fixtures/custom_locations.yml", "test/fixtures/locations.yml", "test/fixtures/mock_addresses.yml", "test/fixtures/mock_families.yml", "test/fixtures/mock_houses.yml", "test/fixtures/mock_organizations.yml", "test/fixtures/mock_people.yml", "test/fixtures/stores.yml", "test/models/company.rb", "test/models/custom_location.rb", "test/models/location.rb", "test/models/mock_address.rb", "test/models/mock_family.rb", "test/models/mock_house.rb", "test/models/mock_organization.rb", "test/models/mock_person.rb", "test/models/store.rb", "test/mysql-debug.log", "test/schema.rb", "test/tasks.rake", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_runtime_dependency(%q<geokit>, ["~> 1.5.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<rcov>, ["~> 0.9.9"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9.8"])
      s.add_development_dependency(%q<mysql>, ["~> 2.8.1"])
    else
      s.add_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_dependency(%q<geokit>, ["~> 1.5.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<rcov>, ["~> 0.9.9"])
      s.add_dependency(%q<mocha>, ["~> 0.9.8"])
      s.add_dependency(%q<mysql>, ["~> 2.8.1"])
    end
  else
    s.add_dependency(%q<rails>, ["~> 3.0.0"])
    s.add_dependency(%q<geokit>, ["~> 1.5.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<rcov>, ["~> 0.9.9"])
    s.add_dependency(%q<mocha>, ["~> 0.9.8"])
    s.add_dependency(%q<mysql>, ["~> 2.8.1"])
  end
end

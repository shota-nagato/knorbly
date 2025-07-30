source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "propshaft"
gem "pg", "~> 1.6"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "erb_lint", require: false
  gem "factory_bot_rails"
  gem "rack-mini-profiler", require: false
  gem "rspec-rails"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "simplecov", require: false
end

group :development do
  gem "annotaterb"
  gem "letter_opener_web"
  gem "hotwire-spark"
  gem "web-console"
end

gem "dry-initializer"
gem "tailwind_merge"
gem "view_component"
gem "view_component-contrib"

gem "bcrypt", "~> 3.1"

begin
  Bundler.require
rescue
end

require 'yaml'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'selenium-webdriver'

app_config = OpenStruct.new( YAML.load(IO.read("config.yml")) )

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Our config
  config.include Capybara::DSL

  config.after :each do |example|
    if example.exception
      file_name = example.id.gsub( /[^a-z0-9\_*]/, '_' ).gsub( /^_*/, '' ).gsub( /_*$/, '' )
      FileUtils.mkdir_p "tmp/errors"
      page.save_screenshot "tmp/errors/#{ file_name }.png", full: true

      puts "\n Screenshot saved to: tmp/errors/#{ file_name }.png"
    end
  end
end

#Capybara.register_driver :selenium_chrome do |app|
#  Capybara::Selenium::Driver.new(app, browser: :chrome)
#end

Capybara.register_driver :selenium do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  # client.timeout = 360 # instead of the default 60
  client.read_timeout = 360
  client.open_timeout = 360
  Capybara::Selenium::Driver.new(app, browser: :chrome, http_client: client)
end

Capybara.javascript_driver = :chrome

Capybara.configure do |config|
    config.default_max_wait_time = 10 # seconds
end

case app_config.browser
when "chrome"
  Capybara.default_driver = :selenium
when "firefox"
  Capybara.default_driver = :selenium
when "poltergeist"
  Capybara.default_driver = :poltergeist
when "webkit"
  Capybara.default_driver = :webkit
else
  Capybara.default_driver = :selenium_chrome
end

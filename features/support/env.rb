require "capybara"
require "capybara/cucumber"
require "rspec"
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
    options = {
        :js_errors => true,
        :timeout => 120,
        :debug => false,
        :phantomjs_options => ['--load-images=no', '--disk-cache=false'],
        :inspector => true,
    }
    Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.javascript_driver = :chrome


Before do 

end

After do |scenario|
	if(scenario.failed?)
       page.save_screenshot("#{File.dirname(__FILE__)}/../../reports/screenshots/#{scenario.name.split.join('_')}.png")
	end
  	browser = Capybara.current_session.driver.browser
	if browser.respond_to?(:clear_cookies)
	  # Rack::MockSession
	  browser.clear_cookies
	elsif browser.respond_to?(:manage) and browser.manage.respond_to?(:delete_all_cookies)
	  # Selenium::WebDriver
	  browser.manage.delete_all_cookies
	else
	  raise "Don't know how to clear cookies. Weird driver?"
	end
end

 at_exit do
 	page.driver.browser.window_handles.each do |handle|
	  	page.driver.browser.switch_to.window(handle)
	  	page.execute_script "window.close()"
	end
 end
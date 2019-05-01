When(/^I login with "(.*?)" and "(.*?)"$/) do |username, password|
  fill_in 'username', :with => username
  fill_in 'password', :with => password
  click_button 'Login'
end

Then(/^I should see "(.*?)" text$/) do |welcome_message|
  page.should have_content welcome_message
end

Then(/^I should see login error message$/) do
  page.should have_content "Invalid user name or password"
end

Given(/^I am on Login Page$/) do
  visit("http://dummy-app/login.html")
end


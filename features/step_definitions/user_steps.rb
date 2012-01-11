
## Givens

Given /^a valid user$/ do
  @user = User.create!({
                 :login => "bertram",
                 :email => "bertram@example.com",
                 :password => "123456",
                 :password_confirmation => "123456"
               })
end

Given /^a logged in user$/ do
  Given "a valid user"
  visit login_url
  fill_in "Login", :with => "bertram"
  fill_in "Password", :with => "123456"
  click_button "Log in"
end

## Whens

## Thens

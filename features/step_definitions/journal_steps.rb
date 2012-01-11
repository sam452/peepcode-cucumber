
Given /^an existing journal entry record with the following data:$/ do |table|
  # table is a Cucumber::Ast::Table
  attributes = table.hashes.inject({}) { |memo, obj|
    memo[obj['key']] = obj['value']
    memo
  }
  @journal_entry = @user.journal_entries.create!(attributes)
end

Given /^an existing nick with the following data:$/ do |table|
  @journal_entry = @user.journal_entries.new()
  table.hashes.each do |hash|
    case hash['key']
    when "date"
      @journal_entry.date = hash['value'].to_date
    when "position"
      @journal_entry.nicks = hash['value'].split(',')
    end
  end
  @journal_entry.save!
end

## Thens

Then /^the calendar should show the current month$/ do
  month_name = Date.today.strftime("%B")
  Then %Q{I should see "#{month_name}" within "th.monthName"}
end

Then %r|^the page should link to /(.+)/$| do |url_re|
  regex = Regexp.new(%Q|href="#{url_re}"|)
  response.body.should match(regex)
end

Then /^the journal title should display today\'s date$/ do
  day_name = Date.today.strftime("%A")
  Then %Q{I should see "#{day_name}" within "h1"}
end

Then /^the record should belong to the current user$/ do
  journal_entry = @user.journal_entries.find_by_date("2010-10-10")
  journal_entry.should_not be_nil
end


Then /^the user\'s journal entry should have the following values:$/ do |table|
  journal_entry = @user.journal_entries.first
  table.hashes.each do |hash|
    journal_entry.send(hash['key']).should == hash['value'].send(hash['transform'])
  end
end

Then /^I should see JSON output containing nick data \'([^\']*)\'$/ do |data_string|
  response.body.should match(/#{data_string}/)
end



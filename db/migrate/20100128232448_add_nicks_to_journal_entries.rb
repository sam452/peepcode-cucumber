class AddNicksToJournalEntries < ActiveRecord::Migration
  def self.up
    add_column :journal_entries, :nicks, :text
  end

  def self.down
    remove_column :journal_entries, :nicks
  end
end

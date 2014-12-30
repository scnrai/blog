class AddFnameAndLnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_attachment :users, :picture
    add_attachment :users, :resume
  end
end

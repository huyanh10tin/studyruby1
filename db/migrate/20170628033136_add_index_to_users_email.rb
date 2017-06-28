class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def up
    add_index :users,:email,unique: true
  end
  def down

  end
end

class CreateSaves < ActiveRecord::Migration[5.1]
  def change
    create_table :save_posts do |t|
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

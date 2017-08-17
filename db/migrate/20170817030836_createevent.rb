class Createevent < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start
      t.datetime :end
      t.string :description
      t.string :color
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

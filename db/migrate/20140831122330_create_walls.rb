class CreateWalls < ActiveRecord::Migration
  def change
    create_table :walls do |t|
      t.string :path
      t.text   :text

      t.timestamps
    end
  end
end

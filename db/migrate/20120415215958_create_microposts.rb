class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :name
      t.string :spotify
      t.string :itunes
      t.string :link

      t.timestamps
    end
  end
end

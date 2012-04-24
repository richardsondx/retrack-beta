class RenameMyColumnByHand < ActiveRecord::Migration
  def up
    rename_column :microposts, :link, :link_url
  end

  def down
    rename_column :microposts, :link_url, :link
  end
end

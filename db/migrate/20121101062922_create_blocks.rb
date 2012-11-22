class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.string :title
      t.string :block_type
      t.text :description

      t.timestamps
    end
  end
end

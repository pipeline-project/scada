class CreateBlobs < ActiveRecord::Migration
  def change
    create_table :blobs do |t|
      t.string :unique_id, unique: true
      t.binary :data
      t.references :step, index: true, foreign_key: true
      t.string :tag, index: true

      t.timestamps null: false
    end
  end
end

class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :name
      t.string :type
      t.integer :order
      t.text :options
      t.references :pipeline, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

class CreatePipelines < ActiveRecord::Migration
  def change
    create_table :pipelines do |t|
      t.string :name
      t.text :description
      t.text :steps

      t.timestamps null: false
    end
  end
end

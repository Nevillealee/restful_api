class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :done
      t.references :agenda, foreign_key: true

      t.timestamps
    end
  end
end

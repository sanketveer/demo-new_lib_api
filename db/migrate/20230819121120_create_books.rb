class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.boolean :available
      t.string :checked_out_by
      t.references :library, null: false, foreign_key: true

      t.timestamps
    end
  end
end

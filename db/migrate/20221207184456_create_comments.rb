class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.text :text

      t.timestamps
    end
  end
end

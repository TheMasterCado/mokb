class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.boolean :user_manageable

      t.timestamps
    end
  end
end

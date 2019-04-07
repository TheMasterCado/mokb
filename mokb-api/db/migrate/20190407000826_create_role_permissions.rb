class CreateRolePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :role_permissions do |t|
      t.references :permission 
      t.references :role 

      t.timestamps
    end
  end
end

class CreateUserRefreshTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :user_refresh_tokens do |t|
      t.references :user
      t.string :token
      t.index :token

      t.timestamps
    end
  end
end

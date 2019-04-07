class CreateUserTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :user_tokens do |t|
      t.references :user, foreign_key: true
      t.string :refresh_token
      t.index :refresh_token

      t.timestamps
    end
  end
end

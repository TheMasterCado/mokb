class CreateUserTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :user_tokens do |t|
    end
  end
end

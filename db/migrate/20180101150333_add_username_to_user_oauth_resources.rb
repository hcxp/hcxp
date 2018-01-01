class AddUsernameToUserOauthResources < ActiveRecord::Migration[5.1]
  def change
    add_column :user_oauth_resources, :username, :string
  end
end

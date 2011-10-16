class CreateRoleUserJoin < ActiveRecord::Migration
  def change
    create_table 'roles_users', :id => false do |t|
      t.column :role_id, :integer
      t.column :user_id, :integer
    end
  end
end

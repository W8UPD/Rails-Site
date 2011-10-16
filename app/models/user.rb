class User < ActiveRecord::Base
  has_many :authentications
  has_and_belongs_to_many :roles
  
  def self.create_from_hash!(hash)
    create(:realname => hash[:realname], :email => hash[:email])
  end

  def in_role?(rolename)
    self.roles.find_by_name(rolename.to_s) != nil
  end
end

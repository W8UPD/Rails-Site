class User < ActiveRecord::Base
  has_many :authentications
  
  def self.create_from_hash!(hash)
    create(:realname => hash[:realname], :email => hash[:email])
  end
end

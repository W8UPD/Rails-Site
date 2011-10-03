class User < ActiveRecord::Base
  has_many :authentications
  
  def self.create_from_hash!(hash)
    create(:realname => hash['user_info']['name'])
  end
end

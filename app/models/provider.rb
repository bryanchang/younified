class Provider < ActiveRecord::Base
  attr_accessible :token, :uid, :user_id, :provider

  belongs_to :user

  # def self.from_omniauth(auth)
  # 	provider = Provider.create(
  # 			:token => auth.credentials.token
  # 			:token_secret => auth.credentials.secret
  # 			:provider => auth.provider
  # 			location:auth.info.location
  # 			user_id:current_user.id
  # 		)
  # end
end

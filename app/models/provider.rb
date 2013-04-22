class Provider < ActiveRecord::Base
  attr_accessible :token, :uid, :user_id, :provider

  belongs_to :user
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable #, :omniauth_providers => [:facebook], :omniauth_providers => [:twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_mem, :provider, :uid, :username #oauth_token, 

  has_many :authentications
  has_many :providers

  def apply_omniauth(omni)
    authentications.build(
        provider: omni['provider'],
        uid: omni['uid'],
        token: omni['credentials'].token,
        token_secret: omni['credentials'].secret
      )
  end2

  def self.from_omniauth(auth)
  	where(auth.slice(:provider, :uid)).first_or_create do |user|
  		user.provider = auth.provider
  		user.uid = auth.uid
  		# user.username = auth.info.nickname
  		user.token = auth.credentials.token
  	end
  end

  def self.new_with_session(params, session)
  	if session ["devise.user_attributes"]
  		new(session["devise.user_attributes"], without_protection: true) do |user|
  			user.attributes = params
  			user.valid?
  		end
  	else
  		super
  	end
  end

  def password_required?
	  (authentications.empty? || provider.blank?) && super 
	end

	# def update_with_password(params, *options)
	#   if encrypted_password.blank?
	#     update_attributes(params, *options)
	#   else
	#     super
	#   end
	# end




  # -----------https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview

  # def self.find_for_facebook_oauth(auth, signed_in_resouce=nil)
  # 	user = User.where(:provider => auth.provider, :uid => auth.uid).first
  # 	unless user
  # 		user = User.create( #name:auth.extra.raw_info.name,
  #                        provider:auth.provider,
  #                        uid:auth.uid,
  #                        #oauth_token:auth.credentials.token

  #                        email:auth.info.email,
  #                        password:Devise.friendly_token[0,20]
  #                        )
  # 	end
  # 	user
  # end

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end

end

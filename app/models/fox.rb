
class Fox < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :orders

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |fox|
      fox.email = auth.info.email
      fox.password = Devise.friendly_token[0, 20]
      fox.name = auth.info.name
      fox.avatar = auth.info.image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
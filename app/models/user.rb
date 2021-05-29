class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable, :omniauthable, 
         omniauth_providers: %i[facebook google_oauth2]

  before_validation :omniauth_new_user, on: :create

  validates :user_name,
            :email,
            presence: true

  validates :password, presence: true, confirmation: true, length: { in: 8..20 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first
  end

  private 

  def omniauth_new_user
    return true unless omniauth_extras.present?

    auth = JSON.parse(omniauth_extras)
    extras = {
      info: auth['info'],
      extra: auth['extra']
    }
    password = Devise.friendly_token[0, 20]

    assign_attributes({
      provider: auth['provider'],
      uid: auth['uid'],
      password: password,
      password_confirmation: password,
      omniauth_extras: extras
    })
  end



end

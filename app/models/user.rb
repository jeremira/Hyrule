class User < ApplicationRecord

  has_one :account, :dependent => :destroy
  accepts_nested_attributes_for :account

  has_many :trips, :dependent => :destroy

  validates :email, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:facebook, :instagram]

  def self.from_fbomniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
     #user.account.name = auth.info.name   # assuming the user model has a name
     #user.account.image = auth.info.image # assuming the user model has an image
     # If you are using confirmable and the provider(s) you use validate emails,
     # uncomment the line below to skip the confirmation emails.
     # user.skip_confirmation!
   end
  end

  def self.from_igomniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = 'temp@changeme.com'
     user.password = Devise.friendly_token[0,20]
     #user.name = auth.info.name   # assuming the user model has a name
     #user.image = auth.info.image # assuming the user model has an image
     # If you are using confirmable and the provider(s) you use validate emails,
     # uncomment the line below to skip the confirmation emails.
     # user.skip_confirmation!
   end
  end

end

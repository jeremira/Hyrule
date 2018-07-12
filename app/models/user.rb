class User < ApplicationRecord
  #after_create :send_greeting_email

  has_one :account, :dependent => :destroy
  accepts_nested_attributes_for :account

  has_many :trips, :dependent => :destroy

  validates :email, presence: true
  validates :email, confirmation: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_fbomniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     user.email = auth.info.email
     user.password = Devise.friendly_token[0,20]
   end
  end

  def self.from_igomniauth(auth)
    #instagram omniauth - Feature not implemented atm
  end

  def send_greeting_email
    # Sends email to user when user is created.
      MainMailer.greeting_email(self).deliver
  end

end

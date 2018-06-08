class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def generate_token
    token = SecureRandom.hex
    self.update_attribute(:auth_token, SecureRandom.hex)
    token
  end
end

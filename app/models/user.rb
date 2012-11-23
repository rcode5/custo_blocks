class User < ActiveRecord::Base

  attr_accessible :name, :email, :password, :password_confirmation

  validates :email,
            presence: true,
            email: true

  validates :password,
            presence: true,
            length: { minimum: 6 },
            confirmation: true,
            if: :password

end

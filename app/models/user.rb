class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tlks, dependent: :destroy
  has_many :spkrs, dependent: :destroy
  has_many :msgs, dependent: :destroy
end

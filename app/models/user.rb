class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         *(:confirmable if ENV['DEVISE_EMAIL_CONFIRMATION_FEATURE_FLAG'] == 'true')

  enum role: { candidate: 0, admin: 1 }

  has_many :resumes, dependent: :destroy
end

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, inverse_of: :creator
  has_many :enrollments
  has_many :attended_events, through: :enrollments, source: :event
end

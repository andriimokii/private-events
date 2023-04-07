class Event < ApplicationRecord
  belongs_to :creator, class_name: User.name, foreign_key: :user_id, inverse_of: :events
  has_many :enrollments, dependent: :destroy
  has_many :attendees, through: :enrollments, source: :user

  scope :past, -> { where("date < ?", DateTime.now) }
  scope :future, -> { where("date > ?", DateTime.now) }
end

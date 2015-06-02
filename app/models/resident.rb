class Resident < ActiveRecord::Base
  belongs_to :user
  has_many :rankings, dependent: :destroy
end

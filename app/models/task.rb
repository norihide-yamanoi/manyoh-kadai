class Task < ApplicationRecord
  validates :name, :detail, presence: true

end

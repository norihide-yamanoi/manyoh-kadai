class Task < ApplicationRecord
  validates :name, :detail, presence: true

  enum status: { 未着手:1,着手中:2,完了:3 }
  enum priority: { 高:1,中:2,低:3 }

  scope :search_name, -> name {where("name LIKE ?", "%#{name}%")}
  scope :search_status, -> status {where(status: status)}

  belongs_to :user

  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
end

class Task < ApplicationRecord
  validates :name, :detail, presence: true


  enum status: { 未着手:1,着手中:2,完了:3 }
  enum priority: { 高:1,中:2,低:3 }
end

class Valuation < ApplicationRecord
  belongs_to :question
  
  scope :likes, -> {where(is_positive: true)}
  scope :dislikes, -> {where(is_positive: false)}
end

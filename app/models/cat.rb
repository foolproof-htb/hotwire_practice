class Cat < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[id name age created_at updated_at]
  end
end

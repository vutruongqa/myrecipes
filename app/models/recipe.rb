class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length:{minimum: 5, maximum: 1000}
  belongs_to :chef
  validates :chef_id, presence: true
  default_scope -> {order(updated_at: :desc)}
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def thumbs_up_total
    self.likes.where(like: true).size
  end

  def thumbs_down_total
    self.likes.where(like: false).size
  end

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end

end
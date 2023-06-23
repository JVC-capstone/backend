class Game < ApplicationRecord
    belongs_to :user
    validates :title, :image, :platform, :genre, :notes, presence: true
end

require 'date_validator'
class Book < ApplicationRecord
    validates :title, presence: true
    validates :title, length: {in: 1..1024}
    validates :author, presence: true
    validates :author, length: {in: 1..1024}
    validates :price, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0}
    validates :price, numericality: {less_than_or_equal_to: 9999999999999999}
    validates :published, presence: true
    validates :published, date: true
end

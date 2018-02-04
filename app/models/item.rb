class Item < ApplicationRecord
  belongs_to :agenda
  validates_presence_of :name
  #same as..
  #validates :name, presence: true
end

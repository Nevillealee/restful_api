class Agenda < ApplicationRecord
  has_many :items, dependent: :destroy
  validates_presence_of :title, :created_by
  #same as..
  #validates :title, presence: true
  #validates :created_by, presence: true
end

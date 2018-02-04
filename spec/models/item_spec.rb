require 'rails_helper'

#test suite for Item model
RSpec.describe Item, type: :model do
  #association test
  #ensure an Item record belongs to a single Agenda record
  it { should belong_to(:agenda) }
  #validation test
  #ensure column name is present before saving
  it { should validate_presence_of(:name) }
end

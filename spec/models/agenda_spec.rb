require 'rails_helper'

#test suite for Agenda model
RSpec.describe Agenda, type: :model do
  #Association test
  #ensure Agenda model has one:many relationship with Item model
  it { should have_many(:items).dependent(:destroy) }
  #
  #association and validation matchers provided via shoulda gem
  #
  # Validation tests
  #ensure columns title and created_by are not null before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end

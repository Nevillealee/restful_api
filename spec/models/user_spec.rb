require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  # ensure User model has a one:many relationship with the Agenda model
  it { should have_many(:agendas) }
  # Validation tests
  # ensure name, email, and password_digest are present before save
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end

class School
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :country, type: String
  field :city, type: String
  field :address, type: String
  field :registration_code, type: String
  field :settings, type: Hash, default: {}

  validates_presence_of :name, :email, :phone, :country, :city, :address
end

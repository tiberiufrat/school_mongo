class School
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :country, type: String
  field :city, type: String
  field :address, type: String
  # field :registration_code, type: String
  # field :settings, type: Hash, default: {}

  validates :name, presence: true
  validates :email, presence: true
  validates :phone, presence: true
end

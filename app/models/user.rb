class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :email, type: String
  field :password_digest, type: String
  field :sign_in_count, type: Integer, default: 0
  field :previous_sign_ins, type: Array, default: []
  field :first_name, type: String
	field :last_name, type: String
	field :phone, type: String
	field :title, type: String
	field :gender, type: Integer
	field :address, type: String
	field :birth_date, type: Date
	field :locale, type: StringifiedSymbol, default: :en
	field :newsletter, type: Boolean, default: true
	field :active, type: Boolean, default: true

  belongs_to :profile, polymorphic: true

  validates_presence_of :email, :password_digest, :first_name, :last_name

  has_secure_password
end

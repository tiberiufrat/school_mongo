class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword
  
  field :email, type: String
  # field :password, type: String
  # field :password_confirmation, type: String
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

  # belongs_to :profile, polymorphic: true

  # validates :email, presence: true
  # validates :password_digest, presence: true
  # validates :first_name, presence: true
  # validates :last_name, presence: true

  has_secure_password
end

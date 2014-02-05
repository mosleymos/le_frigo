class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates_confirmation_of :password, message: "should match confirmation", if: :password

  has_many :products
  #has_many :user_products, :as => :products
end

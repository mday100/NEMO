class User < ActiveRecord::Base
	has_many :posts
	has_many :addresses_users
	has_many :addresses, through: :addresses_users
end

class Post < ActiveRecord::Base
	belongs_to :user
end

class Address < ActiveRecord::Base
	has_many :users, through: :addresses_users
	has_many :addresses_users
end

class AddressesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :address
end

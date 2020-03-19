class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :token_authenticatable

  has_many :authentication_tokens

  has_many :tweets, dependent: :destroy

	has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
	has_many :followers, through: :follower_relationships, source: :follower

	def following
		follower_relationships.where(follower_id: self.id)
	end

	def follow(user_id)
		if follower_relationships.find_by(follower_id: user_id).present?
			self.errors.add(:user, "Already following") and return
		end
		begin
			follow = follower_relationships.new(follower_id: user_id) 
			follow.save
			if follow.errors.present?
				self.errors.add(:user, follow.errors)				
			end
		rescue Exception => e
			self.errors.add(:user, e.message)
		end
	end

	def unfollow(user_id)
		begin
			follower_relationships.find_by(follower_id: user_id).destroy
		rescue Exception => e
			self.errors.add(:user, "Please follow this use first")
		end
	end

end

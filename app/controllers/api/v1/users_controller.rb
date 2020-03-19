module Api  
  module V1
    class UsersController < ApplicationController	
    	def user_profile
				render json: {status: :success, user_details: current_user, followers: current_user.followers, following: current_user.following }	
			end

			def followers_tweets
				tweets = []
				current_user.followers.each do |user|
					tweets << { follower: user, tweets: user.tweets }
				end
				render json: {status: :success, data: tweets}
			end

			def user_followers
				render json: {status: :success, followers: current_user.followers}
			end
    end
  end
end

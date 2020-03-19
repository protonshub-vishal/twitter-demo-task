module Api  
  module V1
    class RelationshipsController < ApplicationController
    	before_action :authenticate_user!

			def follow_user
				current_user.follow(params[:user_id])
				unless current_user.errors.present?
					render json: {message: "Followed Successfully"}
				else
					render json: {message: current_user.errors.messages}, status: 422
				end
			end

			def unfollow_user
				current_user.unfollow(params[:user_id])
				if current_user.errors.present?
					render json: {message: current_user.errors.messages}, status: 422
				else
					render json: {message: "UnFollowed Successfully"}
				end
			end
    end
  end
end
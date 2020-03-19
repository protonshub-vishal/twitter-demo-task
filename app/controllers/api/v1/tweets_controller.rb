module Api  
  module V1
    class TweetsController < ApplicationController	
    	before_action :authenticate_user!

			def index
				render json: { status: :success, tweets: current_user.tweets}
			end

			def create
			  if tweet = current_user.tweets.create(tweets_params)
			    render json: { tweet: tweet, status: :success, message: 'Tweet Created succesfully' }
			  else
			    render json: { status: :success, message: 'Failed to Create Tweet' }
			  end
			end

			def show
				tweet = current_user.tweets.find_by_id(params[:id])
				if tweet.present?
					render json: { status: :success, tweet: tweet.as_json.merge!({user: tweet.user})}
				else
					render json: { message: "Tweet not found" }, status: 422
				end
			end

			def destroy
			  tweet = Tweet.find(params[:id])
			  if tweet && tweet.delete
			    render json: { status: :success, message: 'Tweet destroyed succesfully' }
			  else
			    render json: { status: :success, message: 'Failed to destroy Tweet' }
			  end
			end

			private

			def tweet_params
				params.require(:tweet).permit(:title, :text)
			end
		end
	end
end

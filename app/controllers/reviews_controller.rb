require_relative '../models/restaurant.rb'

class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Restaurant.build_with_user(review_params, current_user)
    # @restaurant.build_review(review_params, current_user)

    if @review.save
      redirect_to restaurants_path
    else
      if @reviews.errors[:user]
        redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

  def build_review(review_params, current_user)
    if !current_user.reviewed_restaurants.include? @restaurant
      @review = reviews.build(review_params)
      @review.save
    end
  end

end

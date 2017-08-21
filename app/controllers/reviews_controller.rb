class ReviewsController < ApplicationController
  def index
    reviews = Review.unscoped
    reviews = reviews.published if params[:published] == 'true'
    reviews = reviews.order('created_at DESC')
    render json: reviews
  end

  def update
    review = Review.find(params[:id])
    review.update permitted_params
    render json: review
  end

  private
  def permitted_params
    params[:review].permit(:published)
  end
end

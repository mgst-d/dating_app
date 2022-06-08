# This is LikesController
class LikesController < ApplicationController
  def create
    Like.create(likes_params) if Like.where(likes_params).empty?

    redirect_to root_path
  end

  def destroy
    binding.irb
    Like.find_by(likes_params).destroy unless Like.where(likes_params).empty?

    redirect_to root_path
  end

  private

  def likes_params
    {liker_id: params[:liker_id], likee_id: params[:likee_id]}
  end
end

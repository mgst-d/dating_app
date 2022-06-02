# This is LikesController
class LikesController < ApplicationController
  def create
    Like.create(like_params) if Like.where(like_params) == []

    redirect_to root_path
  end

  def destroy
    Like.find_by(like_params).destroy if Like.where(like_params) != []

    redirect_to root_path
  end

  private

  def like_params
    params.permit(:liker_id, :likee_id)
  end
end

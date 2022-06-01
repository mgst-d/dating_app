# This is LikesController
class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)

    redirect_to root_path

    respond_to do |format|
      if @like.save
        format.html { redirect_to root_path, notice: 'like was successfully created.' }
      else
        format.html { redirect_to root_path, notice: 'unprocessable_entity' }
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:liker_id, :likee_id)
  end
end

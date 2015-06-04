class RankingsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_ranking, only: [:show, :edit, :update, :destroy]
  layout 'user'

  def index
    if user_signed_in?
      Ranking.load_rankings(current_user)
      @rankings = current_user.rankings
    else
      redirect_to new_user_registration_path
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
    @ranking_options = ['low priority', 'nice-to-have', 'must-have']
  end

  def update
    if @ranking.update(ranking_params)
      redirect_to user_rankings_path
    else
      render :edit
    end
  end

  def destroy
    @ranking.destroy
    redirect_to user_rankings_path
  end

  private

  def find_ranking
    @ranking = current_user.rankings.find(params[:id])
  end

  def ranking_params
    params.require(:ranking).permit(
      :resident_name, :public_transportation, :own_baths, :own_beds, :max_rent,
      :size, :bike_friendly, :parking
    )
  end

end

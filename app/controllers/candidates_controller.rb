class CandidatesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_candidate, only: [:show, :edit, :update, :destroy]

  def index
    @candidates = current_user.candidates.all
  end

  def show
  end

  def new
  end

  def create
    @candidate = current_user.candidates.new(
      zpid: params[:zpid], notes: params[:notes], baths: params[:baths],
      beds: params[:beds], size: params[:size], total_rent: params[:total_rent],
      public_transportation: params[:public_transportation],
      bike_friendly: params[:bike_friendly], parking: params[:parking]
    )
    if @candidate.save
      redirect_to user_candidates_path(current_user)
    else
      redirect_to user_rankings_path(current_user)
    end
  end

  def edit
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to user_candidate_url(current_user, @candidate)
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy
    redirect_to user_candidates_path
  end

  def rank
    @ranked_candidates = Candidate.rank(current_user) # returns hash
  end

  private

  def find_candidate
    @candidate = current_user.candidates.find(params[:id])
  end

  def candidate_params
    params.require(:candidate).permit(
      :zpid, :notes, :baths, :beds, :size, :total_rent, :public_transportation,
      :bike_friendly, :parking)
  end
end


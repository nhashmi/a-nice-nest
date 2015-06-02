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

  private

  def find_candidate
    @candidate = current_user.candidates.find(params[:id])
  end

  def candidate_params
    params.require(:candidate).permit(:zpid, :notes)
  end

end


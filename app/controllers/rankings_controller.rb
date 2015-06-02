class RankingsController < ApplicationController
  before_action :authenticate_user!

  def index
    Ranking.load_residents_and_rankings(current_user)
    @residents = current_user.residents
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
  end

  def destroy
  end
end

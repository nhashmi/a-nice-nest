class CandidatesController < ApplicationController
  before_action :authenticate_user!

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
  end

  def destroy
  end

end

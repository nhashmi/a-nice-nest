class ResidentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @residents = current_user.residents.all
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

class ResidentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_resident, only: [:show, :edit, :update, :destroy]

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

  private

  def find_resident
    @resident = current_user.residents.find_by(resident_id: ranking.resident_id)
  end
end

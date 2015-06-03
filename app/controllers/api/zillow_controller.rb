module Api
  class ZillowController < ApiController
    def search
      @results = ZillowSearcher.new(params).perform
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @results }
      end
      # render :json => ZillowSearcher.new(params).perform
    end

    def detailed_search
      @detailed_results = DetailedSearcher.new(params).perform
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @detailed_results }
      end
    end
  end
end

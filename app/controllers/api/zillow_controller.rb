module Api
  class ZillowController < ApiController
    layout 'user'
    skip_before_filter :verify_authenticity_token
    def search
      @results = ZillowSearcher.new(params).perform
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @results }
      end
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

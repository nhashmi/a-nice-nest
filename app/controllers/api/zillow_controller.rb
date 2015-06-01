module Api
  class ZillowController < ApiController
    def search
      render :json => ZillowSearcher.new(params).perform
    end
  end
end

module Api

  class DetailedSearcher
    def initialize(params)
      @url = "http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?zws-id=" +
      ENV['zillow_id'] + "&zpid=" + params[:zpid]
      @search_params = params
    end

    def perform
      raw = search
      @results ||= clean(raw)
    end

    def search
      HTTParty.get(@url)
    end

    def clean(response)
      if response['updatedPropertyDetails']['message']['code'] == '501'
        error_message = 'We\'re sorry, but the realtor responsible for this
          property does not wish to share data through the Zillow API'
        return error_message
      else
        cleaned_results = response['updatedPropertyDetails']['response']
        cleaned_results['rent'] = @search_params[:rent]
        return cleaned_results
      end
    end
  end
end

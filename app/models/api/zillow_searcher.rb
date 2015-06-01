module Api

  class ZillowSearcher
    def initialize(params)
      @url = "http://www.zillow.com/webservice/GetSearchResults.htm?zws-id=" +
      ENV['zillow_id'] + "&address=" + params[:address] +
      "&citystatezip=" + params[:city] + "%2C%20" + params[:state] + "%20" +
      params[:zip] + "&rentzestimate=true"
      @search_params = params
      # ...
    end

    def perform
      raw = search
      @results ||= clean(raw)
    end

    def search
      HTTParty.get(@url)
    end

    def clean(response)
      results = response["searchresults"]["response"]["results"]["result"]
      binding.pry
      cleaned_results = []
      results.each do |result|
        cleaned_result = {
          :zpid => result["zpid"],
          :rent => result["rentzestimate"]["amount"]["__content__"],
          :links => result["links"],
          :address => result["address"]
        }
        cleaned_results << cleaned_result
      end
      return cleaned_results
    end
  end
end

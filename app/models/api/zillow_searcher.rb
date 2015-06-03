module Api

  class ZillowSearcher
    def initialize(params)
      @url = "http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=" +
      ENV['zillow_id'] + "&address=" + params[:address] +
      "&citystatezip=" + params[:city] + "%2C%20" + params[:state] + "%20" +
      params[:zip] + "&rentzestimate=true"
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
      results = response['searchresults']['response']['results']['result']
      cleaned_results = []
      # Handle cases where search returns multiple properties at the same address
      if results.kind_of?(Array)
        results.each do |result|
          cleaned_result = {
            :zpid => result['zpid'],
            :rent => result['rentzestimate']['amount']['__content__'],
            :links => result['links'],
            :address => result['address'],
            :year_built => result['yearBuilt'],
            :sq_ft => result['finishedSqFt'],
            :baths => result['bathrooms'],
            :beds => result['bedrooms'],
            :rooms => result['totalRooms']
          }
          cleaned_results << cleaned_result
        end
        return cleaned_results
      else
        # Handle cases where search returns one property
        results.each do |result|
          cleaned_result = {
            :zpid => results['zpid'],
            :rent => results['rentzestimate']['amount']['__content__'],
            :links => results['links'],
            :address => results['address'],
            :year_built => results['yearBuilt'],
            :sq_ft => results['finishedSqFt'],
            :baths => results['bathrooms'],
            :beds => results['bedrooms'],
            :rooms => results['totalRooms']
          }
          # API occasionally returns duplicate results, so we only return one
          cleaned_results[0] = cleaned_result
        end
        return cleaned_results
      end
    end
  end
end

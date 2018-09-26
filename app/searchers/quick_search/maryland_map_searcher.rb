module QuickSearch
  # QuickSearch searcher for Maryland Map
  class MarylandMapSearcher < QuickSearch::Searcher
    def search
      resp = @http.get(search_url)
      @response = JSON.parse(resp.body)
    end

    def results
      # TODO
    end

    def search_url
      QuickSearch::Engine::MARYLAND_MAP_CONFIG['search_url'] +
        QuickSearch::Engine::MARYLAND_MAP_CONFIG['query_params'] +
        http_request_queries['not_escaped']
    end

    def total
      @response['totalCount']
    end

    def loaded_link
      QuickSearch::Engine::MARYLAND_MAP_CONFIG['loaded_link'] + http_request_queries['uri_escaped']
    end
  end
end

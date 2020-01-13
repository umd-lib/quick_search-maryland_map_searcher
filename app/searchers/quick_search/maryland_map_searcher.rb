# frozen_string_literal: true

module QuickSearch
  # QuickSearch searcher for Maryland Map
  class MarylandMapSearcher < QuickSearch::Searcher
    def search
      resp = @http.get(search_url)
      @response = JSON.parse(resp.body)
    end

    def results
      return @results_list if @results_list

      @results_list = @response['resultList'].map do |value|
        result = OpenStruct.new(title: value['displayName'],
                                link: value['detailLink'],
                                description: description(value))
        result.date << build_restricted_link if value['restricted']
        result
      end

      @results_list
    end

    # Generates a description for the given result
    def description(result)
      start_year = result['startYear'] || ''
      start_year = start_year.strip
      digitized = result['digitized'].to_s == 'true'

      digitized_image_msg = I18n.t('maryland_map_search.digitized_image_message')

      return nil if start_year.empty? && !digitized
      return digitized_image_msg if start_year.empty?
      return start_year unless digitized

      "#{start_year} - #{digitized_image_msg}"
    end

    def search_url
      QuickSearch::Engine::MARYLAND_MAP_CONFIG['search_url'] +
        QuickSearch::Engine::MARYLAND_MAP_CONFIG['query_params'] +
        http_request_queries['uri_escaped']
    end

    def total
      @response['totalCount']
    end

    def loaded_link
      QuickSearch::Engine::MARYLAND_MAP_CONFIG['loaded_link'] + http_request_queries['uri_escaped']
    end
  end
end

Rails.application.routes.draw do
  mount QuickSearch::MarylandMapSearcher::Engine => "/quick_search-maryland_map_searcher"
end

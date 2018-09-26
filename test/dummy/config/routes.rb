Rails.application.routes.draw do
  mount QuickSearchMarylandMapSearcher::Engine => "/quick_search-maryland_map_searcher"
end

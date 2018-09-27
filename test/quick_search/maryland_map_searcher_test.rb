# frozen_string_literal: true

require 'test_helper'

module QuickSearch
  # Tests for MarylandMapSearcher
  class MarylandMapSearcher::Test < ActiveSupport::TestCase # rubocop:disable Style/ClassAndModuleChildren
    def setup
      @searcher = QuickSearch::MarylandMapSearcher.new(nil, nil, nil)
    end

    test 'truth' do
      assert_kind_of Module, QuickSearch::MarylandMapSearcher
    end

    test 'description should return if all elements are nil, empty, or false' do
      result = { 'startYear' => nil, 'digitized' => nil }
      assert_nil @searcher.description(result)

      result = { 'startYear' => '', 'digitized' => '' }
      assert_nil @searcher.description(result)

      result = { 'startYear' => '', 'digitized' => 'false' }
      assert_nil @searcher.description(result)
    end

    test 'description should have startYear if is only non-nil/non-false element' do
      result = { 'startYear' => 'NoDate', 'digitized' => nil }
      assert_equal 'NoDate', @searcher.description(result)

      result = { 'startYear' => '1984', 'digitized' => '' }
      assert_equal '1984', @searcher.description(result)

      result = { 'startYear' => '1984', 'digitized' => 'false' }
      assert_equal '1984', @searcher.description(result)
    end

    test 'description should have start year and digitized message if non-nil/non-empty elements' do
      digitized_msg = I18n.t('maryland_map_search.digitized_image_message')
      assert !digitized_msg.empty?

      result = { 'startYear' => 'NoDate', 'digitized' => 'true' }
      assert_equal "NoDate - #{digitized_msg}", @searcher.description(result)

      result = { 'startYear' => '1984', 'digitized' => 'true' }
      assert_equal "1984 - #{digitized_msg}", @searcher.description(result)
    end
  end
end

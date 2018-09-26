# frozen_string_literal: true

require 'test_helper'

class QuickSearch
  class MarylandMapSearcher
    # MarylandMapSearcher tests
    class Test < ActiveSupport::TestCase
      test 'truth' do
        assert_kind_of Module, QuickSearch::MarylandMapSearcher
      end
    end
  end
end

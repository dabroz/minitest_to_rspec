# frozen_string_literal: true

require 'minitest_to_rspec/input/model/base'

module MinitestToRspec
  module Input
    module Model
      # Data object.  Represents a `:defn` s-expression.
      class Defn < Base
        def initialize(exp)
          assert_sexp_type(:defn, exp)
          @exp = exp.dup
        end

        def body
          @exp[3..-1]
        end

        def method_name
          @exp[1].to_s
        end

        def test_method?
          method_name.start_with?('test_')
        end

        def setup?
          method_name == 'setup'
        end

        def teardown?
          method_name == 'teardown'
        end
      end
    end
  end
end

# MinitestToRspec

Converts [minitest][8] files to [rspec][9].

[![Build Status][1]][2] [![Code Climate][3]][4] [![Test Coverage][7]][4]

Uses [ruby_parser][14], [sexp_processor][15], and [ruby2ruby][16],
in that order.  Thank you, [Ryan Davis][17]!

Example
-------

Input:

```ruby
require 'test_helper'

# This comment will be discarded!
class BananaTest < ActiveSupport::TestCase
  test "is delicious" do
    assert Banana.new.delicious?
  end
end
```

Output:

```ruby
require("spec_helper")
RSpec.describe(Banana) do
  it("is delicious") { expect(Banana.new.delicious?).to(be_truthy) }
end
```

[RubyParser][14] discards all comments.

The code style is whatever [ruby2ruby][6] feels like printing,
and is not configurable.  The goal is not style, but to get to
rspec quickly.

Usage
-----

### CLI

```bash
gem install minitest_to_rspec
minitest_to_rspec --rails source_file target_file
```

### Ruby

```ruby
require 'minitest_to_rspec'
MinitestToRspec::Converter.new.convert("assert('banana')")
#=> "expect(\"banana\").to(be_truthy)"
```

Supported Assertions
--------------------

Selected assertions from minitest, Test::Unit, and ActiveSupport.
See [doc/supported_assertions.md][5] for rationale.  Contributions
are welcome.

Assertion                   | Arity | Source
--------------------------- | ----- | ------
assert                      |       |
assert_difference           | 1,2   |
assert_equal                |       |
assert_match                |       |
assert_nil                  |       |
[assert_no_difference][12]  |       | ActiveSupport
[assert_nothing_raised][10] |       | Test::Unit
[assert_raise][11]          | 0..2  | Test::Unit
[assert_raises][13]         | 0..2  | Minitest
refute                      |       |
refute_equal                |       |

Notably not yet supported: `assert_not_equal`

Supported Mocha
---------------

Mocha                 | Arity | Block | Notes
--------------------- | ----- | ----- | -------
[expects][21]         | 1     | n/a   |
[stub][19]            | 0,1,2 | no    |
[stub_everything][18] | 0,1,2 | no    | Uses `as_null_object`, not the same.
[stubs][20]           | 1     | n/a   |

Notably not yet supported: `any_instance`

[1]: https://travis-ci.org/jaredbeck/minitest_to_rspec.svg
[2]: https://travis-ci.org/jaredbeck/minitest_to_rspec
[3]: https://codeclimate.com/github/jaredbeck/minitest_to_rspec/badges/gpa.svg
[4]: https://codeclimate.com/github/jaredbeck/minitest_to_rspec
[5]: https://github.com/jaredbeck/minitest_to_rspec/blob/master/doc/supported_assertions.md
[6]: https://github.com/seattlerb/ruby2ruby
[7]: https://codeclimate.com/github/jaredbeck/minitest_to_rspec/badges/coverage.svg
[8]: https://github.com/jaredbeck/minitest_to_rspec/blob/master/doc/minitest.md
[9]: https://github.com/jaredbeck/minitest_to_rspec/blob/master/doc/rspec.md
[10]: http://www.rubydoc.info/gems/test-unit/3.0.9/Test/Unit/Assertions#assert_nothing_raised-instance_method
[11]: http://ruby-doc.org/stdlib-2.1.0/libdoc/test/unit/rdoc/Test/Unit/Assertions.html#method-i-assert_raise
[12]: http://api.rubyonrails.org/classes/ActiveSupport/Testing/Assertions.html#method-i-assert_no_difference
[13]: http://www.rubydoc.info/gems/minitest/5.5.1/Minitest/Assertions#assert_raises-instance_method
[14]: https://github.com/seattlerb/ruby_parser
[15]: https://github.com/seattlerb/sexp_processor
[16]: https://github.com/seattlerb/ruby2ruby
[17]: https://github.com/zenspider
[18]: http://www.rubydoc.info/github/floehopper/mocha/Mocha/API:stub_everything
[19]: http://www.rubydoc.info/github/floehopper/mocha/Mocha/API#stub-instance_method
[20]: http://www.rubydoc.info/github/floehopper/mocha/Mocha/ObjectMethods#stubs-instance_method
[21]: http://www.rubydoc.info/github/floehopper/mocha/Mocha/ObjectMethods:expects

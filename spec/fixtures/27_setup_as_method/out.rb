require("spec_helper")
RSpec.describe(Banana) do
  include(Monkeys)
  before { fend_off_the_monkeys }
  it("is delicious") { expect(Banana.new.delicious?).to(eq(true)) }
  after { appologize_to_the_monkeys }
end

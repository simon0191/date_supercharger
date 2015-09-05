require_relative "test_helper"

class TestDateSupercharger < Minitest::Test
  extend Minitest::Spec::DSL

  let(:now) { DateTime.now }
  let(:monday) { DateTime.now.beginning_of_week }
  let(:tuesday) { monday + 1.day }
  let(:wednesday) { monday + 2.day }
  let(:thursday) { monday + 3.day }
  let(:friday) { monday + 4.day }
  let(:saturday) { monday + 5.day }
  let(:sunday) { monday + 6.day }

  before do
    unless ActiveRecord::Base.connected?
      establish_connection
      days = [monday,tuesday,wednesday,thursday,friday,saturday,sunday]
      days.each do |day|
        create({city: "Bogota",visit_date: day})
      end
    end
  end

  describe "ActiveRecord has established a connection to the database" do

    describe "#_after" do
      it "should not include be inclusive" do
        assert_equal 6, Visit.visit_date_after(monday).count
      end
      it "should raise an ArgumentError when receives more than one param" do
        assert_raises(ArgumentError) { Visit.visit_date_after(monday,:additional_argument) }
      end
      it "should raise an ArgumentError when receives no params" do
        assert_raises(ArgumentError) { Visit.visit_date_after() }
      end
    end

    describe "#_after_or_at" do
      it "should be inclusive" do
        assert_equal 7, Visit.visit_date_after_or_at(monday).count
      end
    end

    describe "#_before" do
      it "should not include be inclusive" do
        assert_equal 6, Visit.visit_date_before(sunday).count
      end
    end

    describe "#_before_or_at" do
      it "should be inclusive" do
        assert_equal 7, Visit.visit_date_before_or_at(sunday).count
      end
    end

    describe "#_between" do
      it "should include from but exclude to" do
        assert_equal 6, Visit.visit_date_between(monday,sunday).count
      end
    end

    describe "#_between_inclusive" do
      it "should include from but exclude to" do
        assert_equal 7, Visit.visit_date_between_inclusive(monday,sunday).count
      end
    end

    describe "#respond_to?" do
      it "should respond_to date supercharger methods" do
        supercharger_methods = [:before,:after,:before_or_at,:after_or_at,:between,:between_inclusive]
        supercharger_methods.each do |method|
          assert_equal true, Visit.respond_to?("visit_date_#{method}")
        end
      end
    end

  end

  describe "ActiveRecord has not established a connection to the database" do
    before do
      ActiveRecord::Base.remove_connection
    end
    it "should not raise exception" do
      assert_equal false, Visit.respond_to?(:unexisting_method)
    end

  end

  private

    def create(attributes, count = 1)
      count.times { Visit.create!(attributes) }
    end
end

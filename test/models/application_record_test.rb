require "test_helper"
require "ostruct"

class ApplicationRecordTest < ActiveSupport::TestCase
  class MockModel
    attr_accessor :id

    def initialize(id_type = :uuid)
      @id_type = id_type
    end

    def class
      mock_class = Class.new
      mock_class.define_singleton_method(:attribute_types) do
        { "id" => ::OpenStruct.new(type: @id_type) }
      end
      mock_class.instance_variable_set(:@id_type, @id_type)
      mock_class
    end

    def generate_uuid_v7
      attribute_types = self.class.attribute_types
      return if attribute_types.nil?
      return if attribute_types["id"].nil?
      return if attribute_types["id"].type != :uuid

      self.id ||= SecureRandom.uuid_v7
    end
  end

  test "generates UUID when id attribute is uuid type" do
    model = MockModel.new(:uuid)
    model.generate_uuid_v7

    assert_not_nil model.id
  end

  test "generated UUID has valid format" do
    model = MockModel.new(:uuid)
    model.generate_uuid_v7

    uuid_regex = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i
    assert_match uuid_regex, model.id
  end

  test "generated UUID is version 7" do
    model = MockModel.new(:uuid)
    model.generate_uuid_v7

    assert_equal "7", model.id.split("-")[2][0]
  end

  test "does not override existing UUID when already set" do
    model = MockModel.new(:uuid)
    existing_uuid = SecureRandom.uuid_v7
    model.id = existing_uuid

    model.generate_uuid_v7

    assert_equal existing_uuid, model.id
  end

  test "does not generate UUID for non-uuid id types" do
    model = MockModel.new(:integer)

    assert_nil model.id

    model.generate_uuid_v7

    assert_nil model.id
  end

  test "SecureRandom generates valid UUID format" do
    uuid = SecureRandom.uuid_v7

    uuid_regex = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i
    assert_match uuid_regex, uuid
  end

  test "SecureRandom generates UUID version 7" do
    uuid = SecureRandom.uuid_v7

    assert_equal "7", uuid.split("-")[2][0]
  end

  test "generates unique UUID values" do
    model1 = MockModel.new(:uuid)
    model2 = MockModel.new(:uuid)

    model1.generate_uuid_v7
    model2.generate_uuid_v7

    assert_not_equal model1.id, model2.id
  end

  test "generates non-nil UUID values" do
    model1 = MockModel.new(:uuid)
    model2 = MockModel.new(:uuid)

    model1.generate_uuid_v7
    model2.generate_uuid_v7

    assert_not_nil model1.id
    assert_not_nil model2.id
  end

  test "UUID contains timestamp within expected range" do
    model = MockModel.new(:uuid)

    before_time = Time.current
    model.generate_uuid_v7

    uuid_hex = model.id.gsub("-", "")
    timestamp_hex = uuid_hex[0, 12]
    timestamp_ms = timestamp_hex.to_i(16)
    uuid_time = Time.at(timestamp_ms / 1000.0)

    assert uuid_time >= before_time - 1.second
  end

  test "UUID timestamp is within upper bound" do
    model = MockModel.new(:uuid)

    model.generate_uuid_v7
    after_time = Time.current

    uuid_hex = model.id.gsub("-", "")
    timestamp_hex = uuid_hex[0, 12]
    timestamp_ms = timestamp_hex.to_i(16)
    uuid_time = Time.at(timestamp_ms / 1000.0)

    assert uuid_time <= after_time + 1.second
  end

  test "before_create callback is properly set up" do
    callbacks = ApplicationRecord._create_callbacks.select { |cb| cb.kind == :before }
    generate_uuid_callback = callbacks.find { |cb| cb.filter == :generate_uuid_v7 }

    assert_not_nil generate_uuid_callback, "before_create :generate_uuid_v7 callback should be defined"
  end

  test "does not raise error with missing attribute types" do
    model = Object.new
    model.define_singleton_method(:id) { @id }
    model.define_singleton_method(:id=) { |value| @id = value }

    mock_class = Class.new
    mock_class.define_singleton_method(:attribute_types) { nil }
    model.define_singleton_method(:class) { mock_class }

    model.define_singleton_method(:generate_uuid_v7) do
      attribute_types = self.class.attribute_types
      return if attribute_types.nil?
      return if attribute_types["id"].nil?
      return if attribute_types["id"].type != :uuid

      self.id ||= SecureRandom.uuid_v7
    end

    assert_nothing_raised { model.generate_uuid_v7 }
  end

  test "does not set id with missing attribute types" do
    model = Object.new
    model.define_singleton_method(:id) { @id }
    model.define_singleton_method(:id=) { |value| @id = value }

    mock_class = Class.new
    mock_class.define_singleton_method(:attribute_types) { nil }
    model.define_singleton_method(:class) { mock_class }

    model.define_singleton_method(:generate_uuid_v7) do
      attribute_types = self.class.attribute_types
      return if attribute_types.nil?
      return if attribute_types["id"].nil?
      return if attribute_types["id"].type != :uuid

      self.id ||= SecureRandom.uuid_v7
    end

    model.generate_uuid_v7
    assert_nil model.id
  end

  test "does not raise error with missing id attribute" do
    model = Object.new
    model.define_singleton_method(:id) { @id }
    model.define_singleton_method(:id=) { |value| @id = value }

    mock_class = Class.new
    mock_class.define_singleton_method(:attribute_types) { {} }
    model.define_singleton_method(:class) { mock_class }

    model.define_singleton_method(:generate_uuid_v7) do
      attribute_types = self.class.attribute_types
      return if attribute_types.nil?
      return if attribute_types["id"].nil?
      return if attribute_types["id"].type != :uuid

      self.id ||= SecureRandom.uuid_v7
    end

    assert_nothing_raised { model.generate_uuid_v7 }
  end

  test "does not set id with missing id attribute" do
    model = Object.new
    model.define_singleton_method(:id) { @id }
    model.define_singleton_method(:id=) { |value| @id = value }

    mock_class = Class.new
    mock_class.define_singleton_method(:attribute_types) { {} }
    model.define_singleton_method(:class) { mock_class }

    model.define_singleton_method(:generate_uuid_v7) do
      attribute_types = self.class.attribute_types
      return if attribute_types.nil?
      return if attribute_types["id"].nil?
      return if attribute_types["id"].type != :uuid

      self.id ||= SecureRandom.uuid_v7
    end

    model.generate_uuid_v7
    assert_nil model.id
  end
end

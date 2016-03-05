require "spec_helper"

describe GenerateData do
  let!(:type) { "boolean" }
  let!(:size) { nil }
  let!(:element) { nil }
  let!(:value) { nil }
  let!(:description) do
    {
      "type" => type,
      "value" => value,
      "size" => size,
      "element" => element,
    }
  end

  subject { described_class.new(description).call }

  context "when to 'type' property" do
    before do
      description.delete("type")
    end

    it "returns string describing what's missing" do
      expect(subject).to eq "Missing properties: type"
    end
  end

  describe "for boolean type" do
    it "returns boolean" do
      expect([TrueClass, FalseClass]).to include subject.class
    end

    it "returns predefined boolean" do
      expect(subject).to eq true
    end

    context "when boolean 'value' provided" do
      let!(:value) { true }

      it "returns given value" do
        expect(subject).to eq true
      end
    end

    context "when non-boolean 'value' provided" do
      let!(:value) { "abc123" }

      it "returns value casted to boolean" do
        expect(subject).to eq true
      end
    end
  end

  describe "for integer type" do
    let!(:type) { "integer" }

    it "returns integer" do
      expect(subject.class).to eq Fixnum
    end

    it "returns predefined integer" do
      expect(subject).to eq 200
    end

    context "when numeric 'value' provided" do
      let!(:value) { 42 }

      it "returns given value as integer" do
        expect(subject).to eq 42
      end
    end

    context "when non-integer 'value' provided" do
      let!(:value) { "123ab" }

      it "returns value casted to integer" do
        expect(subject).to eq 123
      end
    end
  end

  describe "for float type" do
    let!(:type) { "float" }

    it "returns float" do
      expect(subject.class).to eq Float
    end

    it "returns predefined float" do
      allow(Kernel).to receive(:rand).and_return(5)
      expect(subject).to eq 100.0
    end

    context "when numeric 'value' provided" do
      let!(:value) { 42 }

      it "returns given value as float" do
        expect(subject).to eq 42.0
      end
    end

    context "when non-float 'value' provided" do
      let!(:value) { "123ab" }

      it "returns value casted to float" do
        expect(subject).to eq 123.0
      end
    end
  end

  describe "for string type" do
    let!(:type) { "string" }

    it "returns string" do
      expect(subject.class).to eq String
    end

    it "returns predefined string" do
      expect(subject).to eq "default_string"
    end

    context "when string 'value' provided" do
      let!(:value) { "string" }

      it "returns given value as string" do
        expect(subject).to eq "string"
      end
    end

    context "when non-string 'value' provided" do
      let!(:value) { 42 }

      it "returns value casted to string" do
        expect(subject).to eq "42"
      end
    end
  end

  describe "for array type" do
    let!(:type) { "array" }
    let!(:size) { 10 }
    let!(:element) { { "type" => "string", "value" => "stringie" } }

    it "returns array" do
      expect(subject.class).to eq Array
    end

    it "returns array of given size" do
      expect(subject.size).to eq size
    end

    it "returns array of defined elements" do
      expect(subject).to match_array(Array.new(10, "stringie"))
    end

    context "when 'size' or 'element' params missing" do
      before do
        description.delete("size")
        description.delete("element")
      end

      it "returns string describing what's missing" do
        expect(subject).to eq "Missing properties: size, element"
      end
    end

    context "when array 'value' provided" do
      let!(:value) { [1, 2, 3] }

      it "does not care" do
        expect(subject).to match_array(Array.new(10, "stringie"))
      end
    end

    context "when non-array 'value' provided" do
      let!(:value) { 42 }

      it "does not care" do
        expect(subject).to match_array(Array.new(10, "stringie"))
      end
    end
  end

  describe "for hash type" do
    let!(:type) { "hash" }

    before do
      description.merge!({
        "prop1" => {
          "type" => "string",
          "value" => "stringie",
        },
        "prop2" => {
          "missing_type_here!" => true,
        },
      })
    end

    it "returns hash" do
      expect(subject.class).to eq Hash
    end

    it "returns hash with requested properties" do
      expect(subject.keys.size).to eq 2
    end

    it "returns correctly generated elements" do
      expect(subject["prop1"]).to eq("stringie")
    end

    it "returns description of errors for incorrectly specified elements" do
      expect(subject["prop2"]).to eq("Missing properties: type")
    end

    context "when hash 'value' provided" do
      let!(:value) { {"a" => 1} }

      it "does not care" do
        expect(subject.keys).to match_array(["prop1", "prop2"])
      end
    end

    context "when non-hash 'value' provided" do
      let!(:value) { 42 }

      it "does not care" do
        expect(subject.keys).to match_array(["prop1", "prop2"])
      end
    end
  end
end

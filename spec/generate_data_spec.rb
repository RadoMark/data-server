require "spec_helper"

describe GenerateData do
  let(:type) { "boolean" }
  let(:value) { nil }
  let(:description) do
    {
      "type" => type,
      "value" => value,
    }
  end

  subject { described_class.new(description).call }

  describe "for boolean type" do
    it "returns boolean" do
      expect([TrueClass, FalseClass]).to include subject.class
    end

    it "returns predefined boolean" do
      expect(subject).to eq true
    end

    describe "when boolean 'value' provided" do
      let(:value) { true }
      it "returns given value" do
        expect(subject).to eq true
      end
    end

    describe "when non-boolean 'value' provided" do
      let(:value) { "abc123" }
      it "returns value casted to boolean" do
        expect(subject).to eq true
      end
    end
  end

  describe "for integer type" do
    let(:type) { "integer" }
    it "returns integer" do
      expect(subject.class).to eq Fixnum
    end

    it "returns predefined integer" do
      expect(subject).to eq 100
    end

    describe "when numeric 'value' provided" do
      let(:value) { 42 }
      it "returns given value as integer" do
        expect(subject).to eq 42
      end
    end

    describe "when non-integer 'value' provided" do
      let(:value) { "123ab" }
      it "returns value casted to integer" do
        expect(subject).to eq 123
      end
    end
  end

  describe "for float type" do
    let(:type) { "float" }
    it "returns float" do
      expect(subject.class).to eq Float
    end

    it "returns predefined float" do
      allow(Kernel).to receive(:rand).and_return(5)
      expect(subject).to eq 100.0
    end

    describe "when numeric 'value' provided" do
      let(:value) { 42 }
      it "returns given value as float" do
        expect(subject).to eq 42.0
      end
    end

    describe "when non-float 'value' provided" do
      let(:value) { "123ab" }
      it "returns value casted to float" do
        expect(subject).to eq 123.0
      end
    end
  end

  describe "for string type" do
    let(:type) { "string" }
    it "returns string" do
      expect(subject.class).to eq String
    end

    it "returns predefined string" do
      expect(subject).to eq "default_string"
    end

    describe "when string 'value' provided" do
      let(:value) { "string" }
      it "returns given value as string" do
        expect(subject).to eq "string"
      end
    end

    describe "when non-string 'value' provided" do
      let(:value) { 42 }
      it "returns value casted to string" do
        expect(subject).to eq "42"
      end
    end
  end
end

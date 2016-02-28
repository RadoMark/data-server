class GenerateData
  STANDARD_TYPES = ["string", "integer", "float", "boolean", "hash", "array"]
  RESTRICTED_PROPS = ["type", "element", "size", "value"]

  def initialize(description)
    @description = description
  end

  def call
    generate(@description)
  end

  private

  def generate(description)
    standard = STANDARD_TYPES.include?(description["type"])
    send("generate_#{description["type"]}", description) if standard
  end

  def generate_hash(description)
    RESTRICTED_PROPS.each { |prop| description.delete(prop) }
    description.each_with_object({}) do |(property, description), hash|
      generated = generate(description)
      hash[property] = generated unless generated.nil?
    end
  end

  def generate_array(description)
    Array.new(description["size"].to_i) { generate(description["element"]) }
  end

  def generate_boolean(description)
    description["value"] || rand > 0.5
  end

  def generate_string(description)
    description["value"] || (("a".."z").to_a + (0..20).to_a).shuffle
  end

  def generate_float(description)
    description["value"] || (rand * 100)
  end

  def generate_integer(description)
    description["value"] || generate_float(description).round.to_i
  end
end

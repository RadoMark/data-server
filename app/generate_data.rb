class GenerateData
  STANDARD_TYPES = ["string", "integer", "float", "boolean", "hash", "array"]
  RESTRICTED_PROPS = ["type", "element", "size", "value", "random"]
  MissingProps = Class.new(StandardError)

  def initialize(description)
    @description = description
  end

  def call
    generate(@description)
  end

  private

  def generate(description)
    missing_props_info = validate_description(description, "type")
    return missing_props_info unless missing_props_info.nil?
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
    missing_props_info = validate_description(description, "size", "element")
    return missing_props_info unless missing_props_info.nil?
    Array.new(description["size"].to_i) { generate(description["element"]) }
  end

  def generate_boolean(description)
    return !!description["value"] unless description["value"].nil?
    true
  end

  def generate_string(description)
    return description["value"].to_s unless description["value"].nil?
    "default_string"
  end

  def generate_float(description)
    return description["value"].to_f unless description["value"].nil?
    100.0
  end

  def generate_integer(description)
    generate_float(description).round.to_i
  end

  def validate_description(description, *required_props)
    missing = required_props - description.keys
    return "Missing properties: #{missing.join(", ")}" unless missing.empty?
  end
end

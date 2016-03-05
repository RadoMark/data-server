class Generator
  MissingFieldsError ||= Class.new(StandardError)

  RESTRICTED_PROPS ||= ["type", "element", "size", "value"]
  GENERATORS ||= {
    "string" => StringGenerator,
    "integer" => IntegerGenerator,
    "float" => FloatGenerator,
    "boolean" => BooleanGenerator,
    "hash" => HashGenerator,
    "array" => ArrayGenerator,
  }

  def initialize(description)
    @description = description
  end

  def generate
    self.class.validate_general(@description)
    validate_by_type(@description)
    generate_by_type
  rescue Generator::MissingFieldsError => e
    "Missing properties: #{e.message}"
  end

  def self.generate(description)
    validate_general(description)
    GENERATORS[description["type"]].new(description).generate
  rescue Generator::MissingFieldsError => e
    "Missing properties: #{e.message}"
  end

  def self.validate_general(description)
    raise Generator::MissingFieldsError.new("type") if description["type"].nil?
  end

  def self.standard_type?(description)
    GENERATORS.keys.include?(description["type"])
  end

  protected

  def validate_by_type(description)
    true
  end
end

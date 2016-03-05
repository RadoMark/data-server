class ArrayGenerator < Generator
  protected

  def generate_by_type
    Array.new(@description["size"].to_i) { self.class.generate(@description["element"]) }
  end

  def validate_by_type(description)
    missing_fields = ["size", "element"] - description.keys
    raise Generator::MissingFieldsError.new(missing_fields.join(", ")) unless missing_fields.empty?
  end
end

class StringGenerator < Generator
  protected

  def generate_by_type
    @description["value"].nil? ? "default_string" : @description["value"].to_s
  end
end

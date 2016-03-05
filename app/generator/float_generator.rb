class FloatGenerator < Generator
  protected

  def generate_by_type
    @description["value"].nil? ? 100.0 : @description["value"].to_f
  end
end

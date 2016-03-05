class IntegerGenerator < Generator
  protected

  def generate_by_type
    @description["value"].nil? ? 200 : @description["value"].to_i
  end
end

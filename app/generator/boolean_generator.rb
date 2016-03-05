class BooleanGenerator < Generator
  protected

  def generate_by_type
    @description["value"].nil? ? true : !!@description["value"]
  end
end

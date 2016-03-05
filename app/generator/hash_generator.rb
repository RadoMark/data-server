class HashGenerator < Generator
  protected

  def generate_by_type
    RESTRICTED_PROPS.each { |prop| @description.delete(prop) }
    @description.each_with_object({}) do |(property, description), hash|
      hash[property] = self.class.generate(description)
    end.delete_if { |_, v| v.nil? }
  end
end

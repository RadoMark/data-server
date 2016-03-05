class GenerateData
  def initialize(description)
    @description = description
  end

  def call
    Generator.generate(@description)
  end
end

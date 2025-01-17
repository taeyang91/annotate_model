module AnnotateModel
  class ModelFileNotFoundError < StandardError
    def initialize(model_name)
      super("Model file not found: #{model_name}")
    end
  end
end
module AnnotateModel
  class ModelFile
    # Initializes a new ModelFile instance.
    #
    # @param file_path [Pathname] the file path of the model file
    def initialize(file_path)
      @file_path = file_path
    end

    def relative_path
      @file_path.relative_path_from(Rails.root).to_s
    end

    def model_name
      @file_path.relative_path_from(Rails.root.join('app', 'models')).to_s.sub('.rb', '').camelize
    end

    def to_s
      @file_path.to_s
    end
  end
end
module AnnotateModel
  class Finder
    def self.all_model_files
      Dir.glob(Rails.root.join("app", "models", "**", "*.rb"))
    end

    def self.find_model_file(model_name)
        model_path = Rails.root.join("app", "models", "#{model_name.underscore}.rb")
        return model_path if File.exist?(model_path)
        nil
    end
  end
end

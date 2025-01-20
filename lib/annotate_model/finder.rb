module AnnotateModel
  class Finder
    def self.model_files!(model_names)
      model_names.map do |model_name|
        find_model_file!(model_name)
      end
    end

    def self.all_model_files
      files = Dir.glob(Rails.root.join("app", "models", "**", "*.rb")).reject { |file_path| file_path.include?('application_record.rb') }
      files.map do |file|
        ModelFile.new(Pathname.new(file))
      end
    end

    def self.find_model_file(model_name)
      model_path = Rails.root.join("app", "models", "#{model_name.underscore}.rb")
      ModelFile.new(model_path) if File.exist?(model_path)
    end

    def self.find_model_file!(model_name)
      find_model_file(model_name) || raise(ModelFileNotFoundError, "#{model_name}")
    end
  end
end

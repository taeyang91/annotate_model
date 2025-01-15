module AnnotateModel
  class Annotator
    def self.annotate_all
      AnnotateModel::Finder.all_model_files.each do |file|
        annotate_file(file)
      end
    end

    def self.annotate_single(model_name)
      file = AnnotateModel::Finder.find_model_file(model_name)
      if file
        annotate_file(file)
      else
        puts "Model #{model_name} not found."
        exit(1)
      end
    end

    def self.annotate_file(file)
      # TODO: Implement annotation logic
      puts "Annotating #{file}"
    end
  end
end

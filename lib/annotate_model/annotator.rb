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
      end
    end

    def self.annotate_file(file)
      unless AnnotationDecider.new(file).annotate?
        puts "File '#{file}' doesn't contain a valid model class"
        return
      end

      content = File.read(file)
      if content.include?("# == Schema Information")
        puts "Skipping annotation for '#{file}' as it is already annotated."
        return
      end

      schema_info = fetch_schema_info(file)
      return unless schema_info

      annotated_content = <<~ANNOTATION + content
        # == Schema Information
        #
        #{schema_info}
      ANNOTATION

      File.write(file, annotated_content)
      puts "Annotated #{file}"
    end

    def self.fetch_schema_info(file)
      model_name = File.basename(file, ".rb").camelize
      table_name = model_name.tableize

      begin
        columns = ActiveRecord::Base.connection.columns(table_name)
      rescue ActiveRecord::StatementInvalid
        puts "Could not find table '#{table_name}'"
        return
      end

      schema_info = columns.map do |column|
        "# #{column.name.ljust(10)} :#{column.type}#{' ' * (15 - column.type.to_s.length)}#{column.null ? '' : ' not null'}"
      end

      schema_info.join("\n")
    end
  end
end

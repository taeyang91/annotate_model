module AnnotateModel
  class Annotator
    def self.annotate(model_names)
      process_files(AnnotateModel::Finder.model_files!(model_names))
    rescue ModelFileNotFoundError => e
      warn e.message
    end

    def self.annotate_all
      process_files(AnnotateModel::Finder.all_model_files)
    end

    def self.process_files(files)
      run_files = []
      skipped_files = []
      failed_files = []

      files.each do |file|
        result = annotate_file(file)
        case result
        when :run
          run_files << file
        when :skipped
          skipped_files << file
        when :failed
          failed_files << file
        end
      end

      log_results(run_files, skipped_files, failed_files)
    end

    def self.annotate_file(file)
      return :failed unless AnnotationDecider.new(file).annotate?

      content = File.read(file.to_s)
      return :skipped if content.include?("# == Schema Information")

      schema_info = fetch_schema_info(file)
      return :failed unless schema_info

      annotated_content = <<~ANNOTATION + content
        # == Schema Information
        #
        #{schema_info}
      ANNOTATION

      File.write(file.to_s, annotated_content)
      :run
    end

    def self.fetch_schema_info(file)
      table_name = file.model_name.tableize

      begin
        columns = ActiveRecord::Base.connection.columns(table_name)
      rescue ActiveRecord::StatementInvalid
        warn "Could not find table '#{table_name}'"
        return
      end

      columns.map do |column|
        "# #{column.name.ljust(10)} :#{column.type}#{' ' * (15 - column.type.to_s.length)}#{column.null ? '' : ' not null'}"
      end.join("\n")
    end

    def self.log_results(run_files, skipped_files, failed_files)
      puts "Annotated files (#{run_files.size}):"
      run_files.each { |file| puts "  - #{file.relative_path}" }

      puts "Skipped files (#{skipped_files.size}):"
      skipped_files.each { |file| puts "  - #{file.relative_path}" }

      puts "Failed files (#{failed_files.size}):"
      failed_files.each { |file| puts "  - #{file.relative_path}" }
    end
  end
end

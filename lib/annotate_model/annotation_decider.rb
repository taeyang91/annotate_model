# frozen_string_literal: true

module AnnotateModel
  class AnnotationDecider
    SKIP_FLAG = "# == annotate_model:skip"

    def initialize(file)
      @file = file
    end

    def annotate?
      return false if skip_flag_present?

      begin
        klass = @file.model_name.constantize
      rescue NameError
        return false
      end

      annotate_conditions(klass).all?
    end

    private

    def skip_flag_present?
      File.foreach(@file.to_s).any? { |line| line.include?(SKIP_FLAG) }
    end

    def annotate_conditions(klass)
      [
        klass.is_a?(Class),
        klass.respond_to?(:table_exists?) && klass.table_exists?
      ]
    end
  end
end

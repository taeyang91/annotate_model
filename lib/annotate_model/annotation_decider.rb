# frozen_string_literal: true

module AnnotateModel
  class AnnotationDecider
    def initialize(file)
      @file = file
    end

    def annotate?
      klass = ModelClassGetter.call(@file)
      return false unless klass

      annotate_conditions(klass).all?
    end

    private

    def annotate_conditions(klass)
      [
        klass.is_a?(Class),
        klass.respond_to?(:table_exists?) && klass.table_exists?
      ]
    end
  end
end

# frozen_string_literal: true

module AnnotateModel
  class ModelClassGetter
    class << self
      def call(file)
        model_name = file_to_model_name(file)
        begin
          model_name.constantize
        rescue NameError
          nil
        end
      end

      private

      def file_to_model_name(file)
        relative_path = file.sub(Rails.root.join('app', 'models').to_s + '/', '')
        relative_path.to_s.sub('.rb', '').camelize
      end
    end
  end
end

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

    # Returns the model name corresponding to the model file path.
    #
    # @return [String] the model name corresponding to the model file path.
    #
    # @example
    #   For a file path "app/models/admin/user.rb", it returns "Admin::User".
    #   For a file path "app/models/product.rb", it returns "Product".
    def model_name
      @file_path.relative_path_from(Rails.root.join('app', 'models')).to_s.sub('.rb', '').camelize
    end

    # Returns the table name corresponding to the model file path.
    #
    # @return [String] the table name corresponding to the model file path.
    #
    # @example
    #   For a file path "app/models/admin/user.rb", it returns "admin_users".
    #   For a file path "app/models/product.rb", it returns "products".
    def table_name
      @file_path.relative_path_from(Rails.root.join('app', 'models')).to_s.sub('.rb', '').classify.tableize.sub('/', '_')
    end

    def to_s
      @file_path.to_s
    end
  end
end
module AnnotateModel
  class Cli
    def self.start(args)
      options = {}
      OptionParser.new do |opts|
        opts.banner = "Usage: annotate models [options] [model_name]"

        opts.on("-a", "--all", "Annotate all models") do |a|
          options[:all] = a
        end

        opts.on("-h", "--help", "Prints this help") do
          puts opts
          exit
        end
      end.parse!(args)

      if options[:all] || args.empty?
        AnnotateModel::Annotator.annotate_all
      else
        AnnotateModel::Annotator.annotate(args)
      end
    end
  end
end

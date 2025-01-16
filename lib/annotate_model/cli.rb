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

      if options[:all]
        AnnotateModel::Annotator.annotate_all
      elsif args.any?
        args.each do |model_name|
          AnnotateModel::Annotator.annotate_single(model_name)
        end
      else
        puts "Please specify a model name or use -a for all models."
        exit(1)
      end
    end
  end
end

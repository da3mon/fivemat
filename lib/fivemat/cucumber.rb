require 'cucumber/formatter/progress'

module Fivemat
  class Cucumber < ::Cucumber::Formatter::Progress
    include ElapsedTime

    def label(feature)
      feature.short_name
    end

    def before_feature(feature)
      @io.print "#{label(feature)} "
      @io.flush
      @exceptions = []
      @start_time = Time.now
    end

    def after_feature(feature)
      print_elapsed_time @io, @start_time
      @io.puts

      @exceptions.each do |(exception, status)|
        print_exception(exception, status, 2)
      end
    end

    def exception(exception, status)
      @exceptions << [exception, status]
      super if defined?(super)
    end

    def after_features(features)
      @io.puts
      print_stats(features, @options)
      print_snippets(@options)
      print_passing_wip(@options)
    end

    def done
    end
  end
end

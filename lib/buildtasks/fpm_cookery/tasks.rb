require "buildtasks/exceptions"
require "buildtasks/mixins/tasks"
require "rake/tasklib"
require "forwardable"

module BuildTasks
  module FPMCookery
    class Tasks < ::Rake::TaskLib
      include BuildTasks::Mixins::Tasks

      extend Forwardable
      def_delegators :@attributes, :recipe, :fpm_cookery_version, :fpm_version

      def initialize(attributes)
        @attributes = attributes
        validate_attributes
        define_tasks
      end

      private

      def validate_attributes
        unless File.exist?(recipe)
          fail InvalidAttributeError, "recipe file '#{recipe}' not found"
        end

        if File.exist?("Gemfile")
          STDERR.puts "warning: Gemfile overrules fpm_cookery_version and fpm_version"
        end
      end

      def define_tasks # rubocop:disable MethodLength
        task :default => :build

        file "Gemfile" do |t|
          generate_gemfile(t.name)
        end

        desc "Install build dependencies"
        task :deps => "Gemfile" do
          sh "bundle check || bundle install"
        end

        desc "Build packages"
        task :build => :deps do
          sh sudo("bundle exec fpm-cook package --debug #{recipe}")
        end

        desc "Publish built packages"
        task :publish => :build do
          publish_dir = ENV["PUBLISH_DIR"]
          fail "PUBLISH_DIR variable not set in environment" unless publish_dir

          mkdir_p publish_dir
          cp Dir["pkg/*.deb"], publish_dir
        end

        require "rake/clean"
        CLEAN.include %w(cache tmp-build tmp-dest)
        CLOBBER.include %w(pkg)

        self
      end

      def generate_gemfile(path)
        File.open(path, "w") do |f|
          f.write "source 'https://rubygems.org'\n"
          f.write "gem 'fpm-cookery', '#{fpm_cookery_version}'\n"
          f.write "gem 'fpm', '#{fpm_version}'\n"
        end
      end
    end
  end
end

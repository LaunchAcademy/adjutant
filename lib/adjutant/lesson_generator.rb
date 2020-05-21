require 'thor'
module Adjutant
  # Generates the new lesson folder, with the relevant `.lesson.json` and
  # markdown file
  class LessonGenerator < Thor::HiddenCommand
    include Thor::Base
    include Thor::Actions

    attr_reader :title
    attr_reader :slug
    attr_reader :tags
    attr_reader :category
    attr_reader :vimeo_id

    TEMPLATE_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..', 'templates'))

    # options are the are the attributes of the new lesson
    def initialize(options)
      self.destination_root = options.delete(:destination_root)
      super([], options, destination_root: destination_root)
      @title = options[:title]
      @slug = options[:slug]
      @tags = options[:tags]
      @category = options[:category]
      @vimeo_id= options[:vimeo_id]
    end

    # build the new lesson folder, based on its lesson type and slug
    def build
      new_dir = "#{@category}/#{@slug}"
      empty_directory(new_dir)
      template('lesson.json.erb', File.join(new_dir, '.lesson.json'))
      template('etignore.erb', File.join(new_dir, '.etignore'))
      template("#{@category}.md.erb", File.join(new_dir, "#{@slug}.md"))
    end

    class << self
      def source_paths
        [
          TEMPLATE_DIR
        ]
      end
    end
  end
end

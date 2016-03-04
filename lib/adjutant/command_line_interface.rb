require 'stringex'
require 'thor'

require File.join(File.dirname(__FILE__), 'lesson_generator')

module Adjutant
  class CommandLineInterface < Thor
    include Thor::Actions

    desc "video <movie_title>",
      "generates a video lesson"
    def video(movie_title = nil)
      fundamental_asks(movie_title)
      @vimeo_id = ask('Vimeo ID: ')

      Adjutant::LessonGenerator.new({
        title: @title,
        slug: @slug,
        tags: @tags,
        category: "video",
        vimeo_id: @vimeo_id,
        destination_root: self.destination_root
      }).build
    end

    desc "article <article_title>",
      "generates an article lesson"
    def article(article_title = nil)
      fundamental_asks(article_title)
      Adjutant::LessonGenerator.new({
        title: @title,
        slug: @slug,
        tags: @tags,
        category: "article",
        destination_root: self.destination_root
      }).build

    end

    protected
    def fundamental_asks(supplied_title = nil)
      @title = supplied_title || ask("Title:")
      @slug = ask('Slug: ', default: @title.to_url)
      @tags = ask('Tags:')
    end
  end
end

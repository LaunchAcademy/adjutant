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

      generate_lesson('video')
    end

    desc "article <article_title>",
      "generates an article lesson"
    def article(article_title = nil)
      fundamental_asks(article_title)
      generate_lesson('article')
    end

    desc "exercise <exercise>",
      "generates an exercise lesson"
    def exercise(exercise_title = nil)
      fundamental_asks(exercise_title)
      generate_lesson('exercise')
    end

    desc "challenge <challenge>",
      "generates a challenge lesson"
    def challenge(challenge_title = nil)
      fundamental_asks(challenge_title)
      generate_lesson('challenge')
    end

    protected
    def generate_lesson(category)
      Adjutant::LessonGenerator.new({
        title: @title,
        slug: @slug,
        tags: @tags,
        category: category,
        vimeo_id: @vimeo_id,
        destination_root: self.destination_root
      }).build
    end

    def fundamental_asks(supplied_title = nil)
      @title = supplied_title || ask("Title:")
      @slug = ask('Slug: ', default: @title.to_url)
      @tags = ask('Tags:')
    end
  end
end

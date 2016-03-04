require 'stringex'
require 'thor'

require File.join(File.dirname(__FILE__), 'lesson_generator')

module Adjutant
  class CommandLineInterface < Thor
    include Thor::Actions

    desc "movie <movie_title>",
      "generates a movie lesson"
    def movie(movie_title = nil)
      title = movie_title || ask("Title:")
      slug = ask('Slug: ', default: title.to_url)
      tags = ask('Tags:')
      vimeo_id = ask('Vimeo ID: ')

      Adjutant::LessonGenerator.new({
        title: title,
        slug: slug,
        tags: tags,
        category: "video",
        vimeo_id: vimeo_id,
        destination_root: self.destination_root,
      }).build
    end
  end
end

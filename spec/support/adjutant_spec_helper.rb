require("fileutils")

module AdjutantSpecHelper
  def adjutant!(subcommand_with_args)
    Dir.chdir(tmp_path) do
      Bundler.with_clean_env do
        `#{join_paths(bin_path, 'adjutant')} #{subcommand_with_args}`
      end
    end
  end

  def make_tmp_path
    FileUtils.mkdir_p(tmp_path)
  end

  def purge_tmp_dir
    FileUtils.rm_rf(tmp_path)
  end

  def has_dir?(relative_path)
    File.directory?(join_paths(tmp_path, relative_path))
  end

  def has_file?(relative_path)
    FileTest.exists?(join_paths(tmp_path, relative_path))
  end

  protected
  def bin_path
    join_paths(root_path, 'bin')
  end

  def root_path
    join_paths(File.dirname(__FILE__), '../../')
  end

  def join_paths(*paths)
    File.join(*paths)
  end


  #borrowed from thor to quell generator output
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end

  protected
  def tmp_path
    '/tmp/adjutant'
  end
end

RSpec.configure do |config|
  config.include(AdjutantSpecHelper)

  config.before(:each) do
    purge_tmp_dir
    make_tmp_path
  end

  config.after(:each) do
    purge_tmp_dir
  end
end

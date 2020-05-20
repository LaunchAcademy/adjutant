require 'spec_helper'

describe 'generate video' do
  let(:title) { 'Testing 1 2 3' }
  let(:slug) { 'testing-1-2-3' }
  let(:tags) { 'far, boo' }
  let(:vimeo_id) { '4342342' }

  let(:cli) do
    Adjutant::CommandLineInterface.new(['video']).tap do |c|
      c.destination_root = tmp_path
    end
  end

  let(:md_path) { "video/#{slug}/#{slug}.md" }

  before(:each) do
    allow(cli).to receive(:ask).and_return(
      title,
      slug,
      tags,
      vimeo_id
    )
  end

  it 'creates a new directory' do
    run
    expect(has_dir?("video/#{slug}")).to be(true)
  end

  it 'creates a .lesson.yml' do
    run
    expect(has_file?("video/#{slug}/.lesson.yml")).to be(true)
  end

  it 'creates a .etignore' do
    run
    expect(has_file?("video/#{slug}/.etignore")).to be(true)
  end

  it 'creates an md file' do
    run
    expect(has_file?(md_path)).to be(true)
  end

  it 'places the specified vimeo video in the md file' do
    run
    expect(File.read(join_paths(tmp_path, md_path))).to include("{% vimeo_video '#{vimeo_id}'")
  end

  def run
    capture(:stdout) { cli.video }
  end
end

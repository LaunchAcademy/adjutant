require 'spec_helper'

describe 'generate article' do
  let(:title) { 'Testing 1 2 3' }
  let(:slug) { 'testing-1-2-3' }
  let(:tags) { 'far, boo' }

  let(:cli) do
    Adjutant::CommandLineInterface.new(['article']).tap do |c|
      c.destination_root = tmp_path
    end
  end

  before(:each) do
    allow(cli).to receive(:ask).and_return(
      title,
      slug,
      tags
    )
  end

  let(:md_path) { "article/#{slug}/#{slug}.md" }

  it 'creates a new directory' do
    run
    expect(has_dir?("article/#{slug}")).to be(true)
  end

  it 'creates a .lesson.yml' do
    run
    expect(has_file?("article/#{slug}/.lesson.yml")).to be(true)
  end

  it 'creates a .etignore' do
    run
    expect(has_file?("article/#{slug}/.etignore")).to be(true)
  end

  it 'creates an md file' do
    run
    expect(has_file?(md_path)).to be(true)
  end

  def run
    capture(:stdout) { cli.article }
  end
end

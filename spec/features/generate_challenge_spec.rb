require 'spec_helper'

describe 'generate article' do
  let(:title) { 'Testing 1 2 3' }
  let(:slug) { 'testing-1-2-3' }
  let(:tags) { 'far, boo' }

  let(:cli) do
    Adjutant::CommandLineInterface.new(['challenge']).tap do |c|
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

  let(:md_path) { "challenge/#{slug}/#{slug}.md" }

  it 'creates a new directory' do
    run
    expect(has_dir?("challenge/#{slug}")).to be(true)
  end

  it 'creates a .lesson.json' do
    run
    expect(has_file?("challenge/#{slug}/.lesson.json")).to be(true)
  end

  it 'creates a .etignore' do
    run
    expect(has_file?("challenge/#{slug}/.etignore")).to be(true)
  end

  it 'creates an md file' do
    run
    expect(has_file?(md_path)).to be(true)
  end

  def run
    capture(:stdout) { cli.challenge }
  end
end

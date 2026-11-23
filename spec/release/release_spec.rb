# frozen_string_literal: true

if RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3') && Gem.loaded_specs.key?('ruby-gem-release')
  require_relative '../../script/release'
  require 'ruby-gem-release/rspec'

  RSpec.describe MongoidShellRelease do
    include RubyGemRelease::RSpec

    let(:root) { File.expand_path('../..', __dir__) }
    let(:version_source) { File.read(File.join(root, 'lib/mongoid/shell/version.rb')) }

    def with_project(notes)
      with_release_project do |project|
        project.environment.merge!(ENV.to_h.slice('MONGOID_VERSION'))
        project.copy_files(path: root,
                           files: ['mongoid-shell.gemspec', 'script/release.rb', 'lib/**/*.rb', 'CHANGELOG.md', 'CONTRIBUTING.md',
                                   'LICENSE.md', 'README.md', 'RELEASING.md'])
        project.configure_workflow(require: 'script/release', builder: 'MongoidShellRelease.workflow')
        project.write('CHANGELOG.md', [
          '### 1.2.0 (Next)', '', notes, '* Your contribution here.', '',
          '### 1.1.0 (2026/01/01)', '', '* Previous release.', ''
        ].join("\n"))
        project.write('lib/mongoid/shell/version.rb', version_source.sub(/VERSION = (['"])[^'"]+\1/, "VERSION = '1.2.0'"))
        project.commit!
        yield project
      end
    end

    it 'builds the standard ruby-gem-release workflow' do
      expect(described_class.workflow).to be_a(RubyGemRelease::Workflow::RubyGem)
    end

    it 'dates the release and prepares the next patch version' do
      with_project('* [#1](https://github.com/mongoid/mongoid-shell/pull/1): Added a feature - [@dblock](https://github.com/dblock).') do |project|
        project.release!

        released = project.remote_file('v1.2.0', 'CHANGELOG.md')
        expect(released).to match(%r{\A### 1\.2\.0 \(\d{4}/\d{2}/\d{2}\)\n\n#{Regexp.escape('*')} \[#1\]})
        expect(released).not_to include('(Next)', 'Your contribution here.')
        expect(project.remote_file('v1.2.0', 'lib/mongoid/shell/version.rb')).to include("VERSION = '1.2.0'")
        expect(project.remote_file('master', 'CHANGELOG.md')).to start_with("### 1.2.1 (Next)\n\n* Your contribution here.\n\n### 1.2.0 (")
        expect(project.remote_file('master', 'lib/mongoid/shell/version.rb')).to include("VERSION = '1.2.1'")
        expect(project.git('status', '--porcelain')).to be_empty
      end
    end

    it 'rejects placeholder-only notes without changing files or remote refs' do
      with_project('') do |project|
        original = project.git('rev-parse', 'origin/master')
        project.run_task('release:workflow:capture')

        expect { project.run_task('release:validate') }.to raise_error(RuntimeError, /no pending changelog notes/)
        expect(project.git('status', '--porcelain')).to be_empty
        expect(project.git('rev-parse', 'origin/master')).to eq(original)
      end
    end
  end
end

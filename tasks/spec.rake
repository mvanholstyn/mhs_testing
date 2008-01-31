namespace :spec do
  rspec_base = File.expand_path(File.join(RAILS_ROOT, *%w[vendor plugins rspec lib]))
  $LOAD_PATH.unshift(rspec_base) if File.exist?(rspec_base)
  require 'spec/rake/spectask'
  require 'spec/translator'

  desc "Run the specs under spec/selenium"
  Spec::Rake::SpecTask.new(:selenium => "test:db:initialize") do |t|
    t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
    t.spec_files = FileList["spec/selenium/**/*_spec.rb"]
  end
end
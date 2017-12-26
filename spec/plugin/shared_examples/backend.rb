RSpec.shared_examples 'a backend' do |backend, adapter|
  SEARCH_UTIL_ADAPTERS.each do |adapter|
    context "with #{adapter} adapter" do
      context 'literal' do
        settings_dependent_context(backend, adapter, 'literal', regex: 0)
      end

      context 'regex' do
        settings_dependent_context(backend, adapter, 'regex', regex: 1)
      end
    end
  end

  include_context 'dumpable'
end

# TODO completely rewrite
def settings_dependent_context(backend, adapter, matching_type, settings)
  before do
    press ":cd #{working_directory}/spec/fixtures/backend/<Enter>"
    esearch_settings(backend: backend, adapter: adapter, out: 'win')
    esearch_settings(settings)
  end
  after { cmd('bdelete') if bufname("%") =~ /Search/ }

  File.readlines("spec/fixtures/backend/#{matching_type}.txt").map(&:chomp).each do |test_query|
    it "finds `#{test_query}`" do
      press ":call esearch#init()<Enter>#{test_query}<Enter>"
      wait_search_start

      expect { line(1) =~ /Finish/i }.to become_true_within(10.seconds),
        -> { "Expected first line to match /Finish/, got `#{line(1)}`" }
    end
  end
end

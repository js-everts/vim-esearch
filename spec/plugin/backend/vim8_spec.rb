require 'spec_helper'
require 'plugin/shared_examples/backend.rb'
require 'plugin/shared_examples/abortable_backend.rb'
require 'plugin/shared_contexts/dumpable.rb'

context 'esearch' do
  context '#backend' do
    describe '#vim8' do
      it_behaves_like 'a backend', 'vim8'
      it_behaves_like 'an abortable backend', 'vim8'
    end
  end
end

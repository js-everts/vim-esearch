require 'spec_helper'
require 'plugin/shared_examples/backend.rb'
require 'plugin/shared_examples/abortable_backend.rb'
require 'plugin/shared_contexts/dumpable.rb'

context 'esearch' do
  context '#backend' do
    describe '#vimproc' do
      it_behaves_like 'a backend', 'vimproc'
      it_behaves_like 'an abortable backend', 'vimproc'
    end
  end
end

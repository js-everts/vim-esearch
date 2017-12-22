RSpec.shared_examples 'an abortable backend' do |backend|
  context 'abortable' do
    let(:adapter) { 'grep' } # trick with urandom works only with grep
    let(:search_string) { '550e8400-e29b-41d4-a716-446655440000' }
    let(:out) { 'win' }

    before { esearch_settings(backend: backend, adapter: adapter, out: out) }
    after { `ps aux | grep #{search_string} | awk '$0=$2' | xargs kill` }

    context '#out#win' do
      let(:out) { 'win' }

      it 'aborts on bufdelete' do
        press ":call esearch#init({'cwd': '/dev/urandom'})<Enter>#{search_string}<Enter>"
        wait_search_start

        # From :help bdelete
        #   Unload buffer [N] (default: current buffer) and delete it from the buffer list.
        expect { press ':bdelete<Enter>' }
          .to change { `ps aux`.include?(search_string) }
          .from(true)
          .to(false)
      end

      it 'aborts on search restart' do
        2.times do
          press ":call esearch#init({'cwd': '/dev/urandom'})<Enter>#{search_string}<Enter>"
          wait_search_start
        end

        expect(ps_aux_without_sh_delegate_command.scan(/#{search_string}/).count)
          .to eq(1)
      end
    end

    context '#out#qflist' do
      let(:out) { 'qflist' }

      it 'aborts on bufdelete' do
        press ":call esearch#init({'cwd': '/dev/urandom'})<Enter>#{search_string}<Enter>"
        wait_quickfix_enter

        # From :help bdelete
        #   Unload buffer [N] (default: current buffer) and delete it from the buffer list.
        expect { press ':bdelete<Enter>' }
          .to change { `ps aux`.include?(search_string) }
          .from(true)
          .to(false)
      end

      it 'aborts on search restart' do
        2.times do
          press ":call esearch#init({'cwd': '/dev/urandom'})<Enter>#{search_string}<Enter>"
          wait_quickfix_enter
        end

        expect(ps_aux_without_sh_delegate_command.scan(/#{search_string}/).count)
          .to eq(1)
      end
    end
  end
end

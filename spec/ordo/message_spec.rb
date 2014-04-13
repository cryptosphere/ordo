require 'spec_helper'

describe ORDO::Message do
  it 'parses messages' do
    message = described_class.parse test_vector('example_message.txt')
    expect(message['Cipher']).to eq 'ordo.symmetric-encryption:///xsalsa20poly1305'
    expect(message['Content-Transfer-Encoding']).to eq 'binary'
    message.body.should eq 'Some things are better left unread'
  end
end

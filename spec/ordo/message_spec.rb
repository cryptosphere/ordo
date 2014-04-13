# encoding: utf-8

require 'spec_helper'

describe ORDO::Message do
  let(:example_cipher)   { 'ordo.symmetric-encryption:///xsalsa20poly1305' }
  let(:example_encoding) { 'binary' }
  let(:example_message)  { 'Some things are better left unread' }

  it 'parses messages' do
    message = described_class.parse test_vector('example_message.txt')
    expect(message['Cipher']).to eq example_cipher
    expect(message['Content-Transfer-Encoding']).to eq example_encoding
    expect(message.body).to eq example_message
  end
end

# encoding: utf-8

require 'spec_helper'

describe ORDO::Message::Parser do
  let(:example_version)  { 0 }
  let(:example_cipher)   { 'ordo.symmetric-encryption:///xsalsa20poly1305' }
  let(:example_encoding) { 'binary' }
  let(:example_header) do
    [
      '---ORDO MSG v' + example_version.to_s + '---',
      'Cipher: ' + example_cipher,
      'Content-Length: ' + example_body.length.to_s,
      'Content-Transfer-Encoding: ' + example_encoding
    ].join("\r\n") + "\r\n\r\n"
  end
  let(:example_body)    { 'Some things are better left unread' }
  let(:example_message) { example_header + example_body }

  it 'parses messages' do
    parser = subject.parse(example_message)

    parser.version.should eq example_version
    parser.fields.should eq(
      'Cipher'                    => example_cipher,
      'Content-Length'            => example_body.length.to_s,
      'Content-Transfer-Encoding' => example_encoding
    )

    parser.body.should eq example_body
  end

  pending 'raises ParseError if no ORDO MSG header found'

  pending 'raises ParseError if version is invalid'
end

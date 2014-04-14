# encoding: binary

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

    expect(parser.version).to eq example_version
    expect(parser.fields).to eq(
      'Cipher'                    => example_cipher,
      'Content-Length'            => example_body.length.to_s,
      'Content-Transfer-Encoding' => example_encoding
    )

    expect(parser.body).to eq example_body
  end

  it 'raises ParseError if no ORDO MSG header found' do
    begin
      subject.parse('garbage')
    rescue ORDO::ParseError => ex # rubocop:disable all
    end

    expect(ex).to be_a ORDO::ParseError
    expect(ex.to_s).to match(/no.*header/)
  end

  it 'raises ParseError if version is invalid' do
    begin
      subject.parse('---ORDO MSG vX---')
    rescue ORDO::ParseError => ex # rubocop:disable all
    end

    expect(ex).to be_a ORDO::ParseError
    expect(ex.to_s).to match(/invalid version/)
  end

  it 'raises ParseError if invalid fields are encountered' do
    begin
      subject.parse("---ORDO MSG v0---\r\nfoo: bar\r\n\r\n")
    rescue ORDO::ParseError => ex # rubocop:disable all
    end

    expect(ex).to be_a ORDO::ParseError
    expect(ex.to_s).to match(/invalid.*field name/)
  end
end

#!/usr/bin/env ruby

require 'nokogiri'

require 'base64'
require 'stringio'
require 'zlib'

html = Nokogiri::HTML(ARGF)

# rcptData = html.at_css("input[name='rcptData']")
# Base64.decode64(rcptData['value'])

msg = html.xpath('//input[starts-with(@name, "msg")]').to_a
msg.map! { |msg| msg['value'] }

doc = Base64.decode64(msg.inject(:+))
doc.slice! 'SiGaBaQz7H'

xml = Nokogiri::XML(doc)

signature_data = xml.at_css('signature-data')
# Nokogiri::XML Zlib::GzipReader.new(StringIO.new(Base64.decode64(signature_data.text))).read

identity_data = xml.at_css('identity-data')
# Nokogiri::XML Zlib::GzipReader.new(StringIO.new(Base64.decode64(identity_data.text))).read

# ??? = doc.split('</secure-doc>').last

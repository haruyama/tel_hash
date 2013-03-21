#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-

require 'digest'
require 'optparse'

opt = OptionParser.new

directory = '.'
hyphen    = false
hash_name = 'MD5'
opt.on('--directory=VAL') {|v| directory = v }
opt.on('--hyphen')        {|v| hyphen = true }
opt.on('--hash=VAL')      {|v| hash_name = v}

argv   = opt.parse(ARGV)
special = argv[0] || '080'
digest = Digest(hash_name)

fhs = {}

['0'..'9', 'a'..'f'].each { |r|
  r.each { |c|
    fhs[c] = open(directory + File::SEPARATOR + c + '.tsv', 'w')
  }
}

num = '00000000'
while num != '100000000'
  tel = special + num
  hash = digest.hexdigest(tel)
  fhs[hash[0]].print [hash, tel].join("\t"), "\n"
  num.next!
end

fhs.keys { |c|
  fhs[c].close
}

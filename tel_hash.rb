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

tel_hash = {}

['0'..'9', 'a'..'f'].each { |r|
  r.each { |c|
    tel_hash[c] = []
  }
}

# def insert_array(a, v)
#   hash = v[0]
#   index = a.bsearch_lower_boundary { |x| x[0] <=> hash }
#   a.insert(index, v)
# end

num = '00000000'
while num != '100000000'
  tel = special + num
  hash = digest.hexdigest(tel)
  tel_hash[hash[0]].push([hash, tel])
  num.next!
end

tel_hash.keys.sort.each { |c|
  open(directory + File::SEPARATOR + c + '.tsv', 'w') { |f|
    tel_hash[c].sort_by {|a,b| a[0] <=> b[0] }.each { |v|
      f.print v.join("\t") , "\n"
    }
  }
}

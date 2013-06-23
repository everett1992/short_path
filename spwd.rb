def short_path (pwd)
  home = Dir.home
  path = Array.new
  until pwd == '/' || pwd == home
    basename = File.basename(pwd)
    pwd = File.dirname(pwd)
    ents = Dir.entries(pwd)
    path << uniqStr(basename, ents)
  end

  if pwd == home
    path.push('~')
  else
    path.push('')
  end

  return path.reverse.join('/')
end

def uniqStr(target, others)
  string = String.new

  target.length.times do |i|
    char =  target[i]
    removed = false
    others.select! do |other|
      if char == other[i] && other != target
        true
      else
        removed = true
        false
      end
    end
    string << char if removed
    break if others.length == 0
  end

  return string
end

pwd = ARGV[1] || Dir.pwd
puts short_path(pwd)

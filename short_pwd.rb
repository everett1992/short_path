#!/bin/env ruby

class StringTree
  attr_accessor :tree
  def initialize(*strings)
    @tree = {}
    strings.each do |string|
      add(string)
    end
  end

  def add(string)
    if string.nil? || string.empty?
      @tree["\0"] = true
    elsif @tree[string.chr]
      @tree[string.chr].add(string[1..-1])
    else
      @tree[string.chr] = StringTree.new(string[1..-1])
    end
  end

  def to_a
    array = Array.new
    @tree.each do |char, stringTree|
      if char == "\0"
        array << ''
      else
        stringTree.to_a.each do |string|
          array << "#{char}#{string}"
        end
      end
    end
    return array
  end

  def short(string)
    short_string = String.new
    tree = @tree
    string.each_char do |char|
      short_string << char if tree.size > 1
      tree = tree[char].tree
    end
    return short_string
  end
end

path = Array.new
until Dir.pwd == '/' || Dir.pwd == Dir.home
  basename = File.basename(Dir.pwd)
  dirname = File.dirname(Dir.pwd)
  ents = Dir.entries(dirname)
  st = StringTree.new(*ents)
  path << st.short(basename)
  Dir.chdir('..')
end

if Dir.pwd == Dir.home
  path.push('~')
else
  path.push('')
end

path.unshift('')
puts path.reverse.join('/')

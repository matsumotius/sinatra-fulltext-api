# -*- encoding: UTF-8 -*-
require 'MeCab'
require File.dirname(__FILE__) + '/../util/response'
require File.dirname(__FILE__) + '/../util/message'
include Response
include Message

class Parser
  def parse(content)
    begin
      nouns = parse_content(content)
      Response::success({ :noun => nouns.uniq, :rank => make_noun_rank(nouns) })
    rescue => e
      Response::error({ :message => Message::Error::internal })
    end
  end

  def parse_content(word)
    mecab = MeCab::Tagger.new("-Ochasen")
    node = mecab.parseToNode(word)
    nouns = []
    while node
      if /^名詞/ =~ node.feature.split(/,/)[0] then
        nouns.push(node.surface)
      end
      node = node.next
    end
    return nouns
  end

  def make_noun_rank(nouns)
    return nouns.inject(Hash.new(0)) {|h, key| h[key] += 1; h }
  end

  def make_noun_count(nouns)
    count = {}
    for noun in nouns
      count[noun] = count[noun] ? count[noun] + 1 : 1
    end
    return count
  end
end

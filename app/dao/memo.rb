# -*- encoding: UTF-8 -*-
require File.dirname(__FILE__) + '/../database'

class Memo < DB
  def save(query)
    self.open("writer")
    doc = Document::new
    for key in query[:attr].keys
      doc.add_attr("@#{key}", query[:attr][key])
    end
    for text in query[:text]
      doc.add_text(text)
    end
    self.put(doc)
    self.close
    return doc
  end

  def find(query)
    result = search(query)
    docs = []
    for index in 0...result.doc_num
      doc = find_by_id(result.get_doc_id(index))
      docs.push(doc)
    end
    return docs
  end

  def find_by_id(id)
    self.open("reader")
    doc = @db.get_doc(id.to_i, 0)
    self.close
    return doc
  end

  def search(query)
    self.open("reader")
    cond = Condition::new
    cond.set_phrase(query)
    result = @db.search(cond)
    self.close
    return result
  end

  def remove(id)
    self.open("writer")
    self.out(id.to_i)
    self.close
  end
end

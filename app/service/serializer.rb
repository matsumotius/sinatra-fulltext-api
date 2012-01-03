class Serializer
  def serialize_docs(docs)
    result = []
    for doc in docs
      result.push(serialize_doc(doc))
    end
    return result
  end

  def serialize_doc(doc)
    result = { :attr => {}, :text => [], :keyword => doc.keywords() }
    for name in doc.attr_names()
      key = name[1..name.length]
      result[:attr][key] = doc.attr(name)
    end
    for text in doc.texts
      result[:text].push(text)
    end
    return result
  end
end

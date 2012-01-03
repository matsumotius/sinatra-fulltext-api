class QueryService
  def initialize
    @attr_keys = [:title, :author]
  end
  
  def search(params)
    query = ""
    texts = params[:keyword]
    for index in 0...texts.length
      query += " AND " if index > 0
      query += texts[index]
    end
    return query
  end

  def search_similarity(params)
    config = params[:config] || "16 1024 4096"
    return params[:keyword].inject("[SIMILAR] #{config}") do |r, (k,v)|
      r << " WITH #{v} #{k}"
    end
  end

  def save_from_params(params)
    query = {
      :attr => {
        "uri" => params[:uri]
      },
      :text => [params[:text]]
    }
    query[:attr]["title"] = params[:title] if params[:title]
    query[:attr]["author"] = params[:author] if params[:author]
    return query
  end
end

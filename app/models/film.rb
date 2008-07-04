class Film < ActiveRecord::Base
  before_save :set_permalink
  
  def imdb_link
    if imdb_id.nil?
      return
    else
      return "http://www.imdb.com/title/%s/" % (imdb_id)
    end
  end
  
  def self.find(*args)
    if args.first.is_a?(String) and args.first !=~ /^\d+$/
      find_by_permalink(args.shift, *args) or raise ActiveRecord::RecordNotFound
    else
      super
    end
  end
  
  def self.search(search)
    if search
      search.strip!
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  
  def to_param
    permalink
  end
  
  private
  
  def set_permalink
    self.permalink = generate_permalink
  end
  
  def generate_permalink
    title.gsub(/[^a-zA-Z0-9\_\-]/, "_").downcase!
  end
end

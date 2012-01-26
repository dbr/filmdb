class Film < ActiveRecord::Base
  before_save :auto_fill_imdb_id
  before_save :regen_permalink
  
  has_permalink :title 
  def to_param
    imdb_id
  end
  
  named_scope :order_title, :order => 'title'
  named_scope :has_imdb, :conditions => ['imdb_id LIKE "tt%%"']
  named_scope :no_imdb, :conditions => ['imdb_id NOT LIKE "tt%%"']
  
  named_scope :search, lambda{ |*args| {:conditions => ['title LIKE ?', "%%#{args.first}%%" || '%%']}}
  
  
  def regen_permalink
    self.permalink = PermalinkFu.escape(self.title)
  end
  
  def auto_fill_imdb_id
    if imdb_id==""
      begin
        self.imdb_id = Imdb.find_movie_by_name(self.title).imdb_id || ""
      rescue OpenURI::HTTPError
        self.imdb_id = ""
      end
    end
  end
  
  def imdb_link
    if imdb_id.nil?
      return
    else
      return "http://www.imdb.com/title/%s/" % (imdb_id)
    end
  end
  
end

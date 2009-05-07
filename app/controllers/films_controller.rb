class FilmsController < ApplicationController
  auto_complete_for :film, :title
  # Require auth for everything except /films/ and /films/2
  before_filter :authenticate, :except => [:index, :show]

  def index
    @films = Film.order_title.find(:all)
    @films = Film.order_title.has_imdb if params[:imdb] == "true"
    @films = Film.order_title.no_imdb if params[:imdb] == "false"
    
    @films = Film.order_title.search( params[:search].strip ) if params[:search]
    
    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js
      format.text # index.txt.erb
      format.yaml { render :text => @films.to_yaml }
      format.xml { render :xml => @films.to_xml }
    end
  end

  def show
    begin
      @film = Film.find_by_permalink(params[:id])
      raise ActiveRecord::RecordNotFound, "Film not found" if @film.nil?
      
      if params[:imdb_id_check]
        @imdb_data = @film.imdb_id.nil? ? nil : Imdb.find_movie_by_id(@film.imdb_id)
        render :layout => "films", :partial => "confirm_imdb_result"
      end
      
      if params[:imdb_id_correct]
        @imdb_data = @film.imdb_id.nil? ? nil : Imdb.find_movie_by_id(@film.imdb_id)
        @film.title = @imdb_data.title
        if @film.save
          render :action => "show"
        end
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Unknown film..."
      redirect_to :action => "index", :status => '404 Not Found'
      return
    end
  end

  def new
    @film = Film.new
  end

  def edit
    @film = Film.find_by_permalink(params[:id])
  end

  def create
    @film = Film.new(params[:film])

    if @film.save
      flash[:notice] = 'Film was successfully created.'
      redirect_to(@film)
    else
      render :action => "new"
    end
  end

  def update
    @film = Film.find_by_permalink(params[:id])

      if @film.update_attributes(params[:film])
        flash[:notice] = 'Film was successfully updated.'
        redirect_to(@film)
      else
        render :action => "edit"
      end
  end

  def destroy
    @film = Film.find_by_permalink(params[:id])
    @film.destroy

    redirect_to(films_url)
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "dbr" && password == "test"
    end
  end
end

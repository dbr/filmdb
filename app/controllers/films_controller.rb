class FilmsController < ApplicationController
  # Require auth for everything except /films/ and /films/2
  before_filter :authenticate, :except => [:index, :show]

  def index
    @films = Film.search(params[:search])
    # @films = Film.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.text # index.txt.erb
      format.xml  { render :xml => @films }
    end
  end

  def show
    begin
      @film = Film.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Unknown id..."
      redirect_to :action => "index"
      return
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @film }
    end
  end

  def new
    @film = Film.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @film }
    end
  end

  def edit
    @film = Film.find(params[:id])
  end

  def create
    @film = Film.new(params[:film])

    respond_to do |format|
      if @film.save
        flash[:notice] = 'Film was successfully created.'
        format.html { redirect_to(@film) }
        format.xml  { render :xml => @film, :status => :created, :location => @film }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @film.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @film = Film.find(params[:id])

    respond_to do |format|
      if @film.update_attributes(params[:film])
        flash[:notice] = 'Film was successfully updated.'
        format.html { redirect_to(@film) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @film.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @film = Film.find(params[:id])
    @film.destroy

    respond_to do |format|
      format.html { redirect_to(films_url) }
      format.xml  { head :ok }
    end
  end

  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "dbr" && password == "test"
    end
  end
end

class FilmsController < ApplicationController
  # Require auth for everything except /films/ and /films/2
  before_filter :authenticate, :except => [:index, :show]

  def index
    @films = Film.search(params[:search])
    # @films = Film.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.text # index.txt.erb
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
  end

  def new
    @film = Film.new
  end

  def edit
    @film = Film.find(params[:id])
  end

  def create
    @film = Film.new(params[:film])

    respond_to do |format|
      if @film.save
        flash[:notice] = 'Film was successfully created.'
        redirect_to(@film)
      else
        render :action => "new"
      end
    end
  end

  def update
    @film = Film.find(params[:id])

    respond_to do |format|
      if @film.update_attributes(params[:film])
        flash[:notice] = 'Film was successfully updated.'
        redirect_to(@film)
      else
        render :action => "edit"
      end
    end
  end

  def destroy
    @film = Film.find(params[:id])
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

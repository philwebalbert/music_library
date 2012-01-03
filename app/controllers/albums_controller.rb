class AlbumsController < ApplicationController
  
  before_filter :authorize_access
  
  # GET /albums
  # GET /albums.xml
  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @artists = Artist.find(:all)
    @features = Feature.find(:all)
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @artists = Artist.find(:all)
    @features = Feature.find(:all)
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = Album.new(params[:album])
    artist = Artist.find(params[:artist_id])
    @album.artist = artist
    @features = Feature.find(:all)
    
    check_features = check_features_using(params[:feature_list])
    uncheck_missing_features(@features, check_features)
    
    respond_to do |format|
      if @album.save
        format.html { redirect_to(@album, :notice => 'Album was successfully created.') }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        @artists = Artist.find(:all)
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find(params[:id])
    artist = Artist.find(params[:artist_id])
    @album.artist = artist
    @features = Feature.find(:all)
    
    check_features = check_features_using(params[:feature_list])
    uncheck_missing_features(@features, check_features)
           
    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to(@album, :notice => 'Album was successfully updated.') }
        format.xml  { head :ok }
      else
        @artists = Artist.find(:all)
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to(albums_url) }
      format.xml  { head :ok }
    end
  end
  
  private #-----------------------------------------------------------------
  
  def check_features_using( feature_id_array )
    checked_features = []
    check_params = feature_id_array || []
    for check_box_id in check_params 
      feature = Feature.find(check_box_id)
      if not @album.features.include?(feature)
        @album.features << feature
      end
      checked_features << feature
    end
    
    return checked_features
  end
  
  def uncheck_missing_features( features, checked_features)
    missing_features = features - checked_features
    for feature in missing_features
      if @album.features.include?(feature)
        @album.features.delete(feature)
      end 
    end
  end
  
end

class RefresherController < ApplicationController
  
  def album_list
    @albums = Album.find_by_sql('SELECT * FROM albums WHERE release_date <= \'2005-01-01\' 
                                AND artist_old LIKE \'%All-American%\'
                                ORDER BY release_date ASC;')
    render(:layout => false)
  end
  
  def alt_album_list
    release_date = '2011-01-01'
    artist = 'Stone'
    @albums = Album.find(:all, 
        :conditions => ["release_date <= ? AND artist_old LIKE ?", release_date, '%' + artist + '%'],
        :order => 'title, release_date ASC',
        :limit => 10, :offset => 0)
    render(:layout => false, :action => 'album_list')
  end
  
  def show_album
    release_date = '2011-01-01'
    artist = 'Script'
    @album = Album.find(:first , 
        :conditions => ["release_date <= ? AND artist_old LIKE ?", release_date, '%' + artist + '%'],
        :order => 'title, release_date ASC',
        :limit => 2, :offset => 2)
    render(:layout => false)
  end
  
  def show
    @album = Album.find_by_id(params['id'])
    render(:layout => false, :action => 'show_album')
  end
  
  def list
    @albums = Album.find(:all)  
    render(:layout => false, :action => 'album_list')
  end
  
  def new
    @album = Album.new
    render(:layout => false)
  end
  
  def create
    @album = Album.new(params[:album])
    if @album.save
      redirect_to(:action => 'list')
    else
      render(:layout => false, :action => 'new')
    end
  end
    
  def edit
    @album = Album.find_by_id(params[:id])
    render(:layout => false)
  end
  
  def update
    @album = Album.find_by_id(params[:id])
    if @album.update_attributes(params[:album])
      redirect_to(:action => 'list')
    else
      render(:layout => false, :action => 'edit')
    end
  end
  
  def destroy
    @album = Album.find_by_id(params[:id])
    @album.destroy
    redirect_to(:action => 'list')
  end
  
end

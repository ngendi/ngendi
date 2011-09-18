class PlacesController < ApplicationController
  before_filter :authenticate, :except => [:show, :result, :home ]
  # GET /places
  # GET /places.xml
  def index
    @tags = Place.tag_counts
    @places = Place.find(:all)
    respond_to do |format|
      format.html { render :layout => "admin" }  # index.html.erb
      format.xml  { render :xml => @places }
    end
  end

  def home
    respond_to do |format|
      format.html { render :layout => "home" }  # home.html.erb
    end
  end

  #show search results page
  def result
    session[:lat] = params[:lat]
    session[:lng] = params[:lng]
    @lat = Float(params[:lat])
    @lng = Float(params[:lng])
    lat = (@lat / 180.0) * Math::PI
    lng = (@lng / 180.0) * Math::PI

    @places = Place.search params[:search], :page => params[:page], :per_page => 5, :match_mode => :boolean, :geo => [lat,lng], :with => {"@geodist" => 0.0..7_000.0}, :order => "@geodist ASC, @relevance DESC"

    respond_to do |format|
      format.html { render :layout => "result" } # result.html.erb
      format.xml  { render :xml => @places }
    end
  end

  #get tags
  def tag
    @places = Place.find_tagged_with params[:id]
  end

  # GET /places/1
  # GET /places/1.xml
  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.html { render :layout => "show" } # show.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Place.new
    respond_to do |format|
      format.html { render :layout => "admin" } # new.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/1/edit
  def edit
    if admin? 
      @place = Place.find(params[:id])
    else
      @place = current_user.places.find(params[:id])
    end
    respond_to do |format|
      format.html { render :layout => "admin" }  # index.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # POST /places
  # POST /places.xml
  def create
    @place = current_user.places.new(params[:place])

    respond_to do |format|
      if @place.save
        p = Place.find(:first)
        p.tag_list = params[:place][:tag_list]
        p.save

        format.html { redirect_to(@place, :notice => 'Place was successfully created.') }
        format.xml  { render :xml => @place, :status => :created, :location => @place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.xml
  def update
    @place = current_user.places.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to(@place, :notice => 'Place was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.xml
  def destroy
    @place = current_user.places.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to(places_url) }
      format.xml  { head :ok }
    end
  end
end

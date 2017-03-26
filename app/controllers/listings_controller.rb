class ListingsController < ApplicationController
  before_action :set_listings, except: [:index]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # GET users/1/listings
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @listings = @user.listings.page params[:page]
    else
      @listings = Listing.all.page params[:page]
    end
    if params[:tag]
      @Listings = Listing.tagged_with(params[:tag])
    else
      @Listings = Listing.all
    end
  end

  # GET users/1/listings/1
  def show
  end

  # GET users/1/listings/new
  def new
    @listing = @user.listings.build
  end

  # GET users/1/listings/1/edit
  def edit
  end

  # POST users/1/listings
  def create
    @listing = @user.listings.build(listing_params)

    if @listing.save
      redirect_to([@listing.user, @listing], notice: 'Listing was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT users/1/listings/1
  def update
    if @listing.update_attributes(listing_params)
      redirect_to([@listing.user, @listing], notice: 'Listing was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE users/1/listings/1
  def destroy
    @listing.destroy

    redirect_to user_listings_url(@user)
  end

  def tagged
    if params[:tag].present?
      @listings = Listing.tagged_with(params[:tag])
    else
      @listings = Listing.all
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listings
      @user = User.find(params[:user_id])
    end

    def set_listing
      @listing = @user.listings.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def listing_params
      params.require(:listing).permit(:name, :location, :description, :price, :tag_list, photos: [])
    end
end

class FeedsController < ApplicationController
  def index
    @feeds = Feed.includes(:entries).all
    @json_feeds = @feeds.as_json(include: :entries)
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => @json_feeds }
    end
  end

  def create
    feed = Feed.find_or_create_by_url(feed_params[:url])
    if feed
      render :json => feed
    else
      render :json => { error: "invalid url" }, status: :unprocessable_entity
    end
  end

  private
  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end

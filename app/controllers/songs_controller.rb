class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  # GET /songs
  # GET /songs.json
  def index
    @search = Song.search(params[:q]) #Using the Ransack Gem
    @page = params[:page] || 1
    @songs = @search.result.includes(:artist).paginate(:page => @page, :per_page => 50)
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload
    if request.post?
      if !(params && params[:import] && params[:import][:file])
        flash[:error] = 'No file selected'
      else
        #import
        name = params[:import][:file].original_filename

        temp_filename =  "SONG" + SecureRandom.hex + '.csv'
        # path = File.join('tmp', temp_filename)
        # File.open(path, "wb") { |f| f.write(params[:import][:file].read) }

        temp_file_path = params[:import][:file].path
        s3_path = upload_to_s3(temp_file_path, temp_filename)
        SongImportWorker.perform_async(s3_path)
        flash[:notice] = 'Queued for processing'
      end
      redirect_to upload_songs_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params.require(:song).permit(:name, :artist_id, :length_in_sec, :year, :top_billboard_spot, :billboard_weeks)
    end

    def set_tab
      @tab = 'song'
    end

    def upload_to_s3(file, file_key)
      s3 = Aws::S3::Resource.new(
        credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
        region: 'us-east-1'
      )
 
      obj = s3.bucket(ENV['S3_BUCKET']).object(file_key)
      obj.upload_file(file, acl:'public-read')
      obj.public_url
    end
end

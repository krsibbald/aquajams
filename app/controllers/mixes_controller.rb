class MixesController < ApplicationController
  before_action :set_mix, only: [:show, :edit, :update, :destroy]

  # GET /mixes
  # GET /mixes.json
  def index
    @search = Mix.search(params[:q]) #Using the Ransack Gem
    @page = params[:page] || 1
    @mixes = @search.result.paginate(:page => @page, :per_page => 50)
  end

  # GET /mixes/1
  # GET /mixes/1.json
  def show
  end

  # GET /mixes/new
  def new
    @mix = Mix.new
  end

  # GET /mixes/1/edit
  def edit
  end

  # POST /mixes
  # POST /mixes.json
  def create
    @mix = Mix.new(mix_params)

    respond_to do |format|
      if @mix.save
        format.html { redirect_to @mix, notice: 'Mix was successfully created.' }
        format.json { render :show, status: :created, location: @mix }
      else
        format.html { render :new }
        format.json { render json: @mix.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mixes/1
  # PATCH/PUT /mixes/1.json
  def update
    respond_to do |format|
      if @mix.update(mix_params)
        format.html { redirect_to @mix, notice: 'Mix was successfully updated.' }
        format.json { render :show, status: :ok, location: @mix }
      else
        format.html { render :edit }
        format.json { render json: @mix.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mixes/1
  # DELETE /mixes/1.json
  def destroy
    @mix.destroy
    respond_to do |format|
      format.html { redirect_to mixes_url, notice: 'Mix was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload
    if request.post?
      if !(params && params[:import] && params[:import][:file])
        flash[:error] = 'No file selected'
      elsif false
        #import
        name = params[:import][:file].original_filename

        temp_filename =  'MIX' + SecureRandom.hex + '.csv'
        path = File.join('tmp', temp_filename)
        File.open(path, "wb") { |f| f.write(params[:import][:file].read) }

        MixImportWorker.perform_async(path)
        flash[:notice] = 'Queued for processing'
      else
        temp_file = params[:import][:file]

        if  ! File.extname(temp_file.original_filename).match(/\A\.csv\z/i)
          ImporterLog.create(importer: self.name.underscore, status: "File does not appear to be a CSV file")
        else
          remote_filename =  SecureRandom.hex + '.csv'

         Aws::config.update({
            region: 'us-east-1',
            credentials: Aws::Credentials.new( ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
          })
         # s3 =Aws::S3::Client.new
          # s3 = Aws::S3.new(
          #   access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          #   secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
          # )
          s3 = Aws::S3::Resource.new(region:'us-east-1')
          s3_file = s3.bucket(ENV['S3_BUCKET']).object(remote_filename)

          s3_file.upload_file(params[:import][:file])

          # s3_file = s3.buckets(ENV['S3_BUCKET']).object(remote_filename)
          # s3_file.write(file: temp_file.path, acl: :public_read)
          Rails.logger.debug("uploaded csv to #{s3_file.public_url.to_s}")
          flash[:notice]= "Uploaded to #{s3_file.public_url.to_s}"
          # CsvImportJob.perform_later(self.name.underscore, s3_file.public_url.to_s, temp_file.original_filename, opts)
        end
      end
      redirect_to upload_mixes_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mix
      @mix = Mix.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mix_params
      params.require(:mix).permit(:name, :length_in_sec, :recorded_at, :description, :source, :music_type, :notes)
    end

    def set_tab
      @tab = 'mix'
    end
end

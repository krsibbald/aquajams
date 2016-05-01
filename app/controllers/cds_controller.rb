class CdsController < ApplicationController
  before_action :set_cd, only: [:show, :edit, :update, :destroy]

  # GET /cds
  # GET /cds.json
  def index
    @cds = Cd.all
  end

  # GET /cds/1
  # GET /cds/1.json
  def show
  end

  # GET /cds/new
  def new
    @cd = Cd.new
  end

  # GET /cds/1/edit
  def edit
  end

  # POST /cds
  # POST /cds.json
  def create
    @cd = Cd.new(cd_params)

    respond_to do |format|
      if @cd.save
        format.html { redirect_to @cd, notice: 'Cd was successfully created.' }
        format.json { render :show, status: :created, location: @cd }
      else
        format.html { render :new }
        format.json { render json: @cd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cds/1
  # PATCH/PUT /cds/1.json
  def update
    respond_to do |format|
      if @cd.update(cd_params)
        format.html { redirect_to @cd, notice: 'Cd was successfully updated.' }
        format.json { render :show, status: :ok, location: @cd }
      else
        format.html { render :edit }
        format.json { render json: @cd.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cds/1
  # DELETE /cds/1.json
  def destroy
    @cd.destroy
    respond_to do |format|
      format.html { redirect_to cds_url, notice: 'Cd was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cd
      @cd = Cd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cd_params
      params.require(:cd).permit(:name, :code, :time_in_sec)
    end
end

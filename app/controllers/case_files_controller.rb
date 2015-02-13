class CaseFilesController < ApplicationController
  respond_to :json
  before_action :set_case_file, only: [:show, :edit, :update, :destroy]

  # GET /case_files
  # GET /case_files.json
  def index
    @case_files = CaseFile.by_id
    render json: @case_files
  end

  # GET /case_files/1
  # GET /case_files/1.json
  def show
  end

  # GET /case_files/new
  def new
    @case_file = CaseFile.new
    @case_file.save!
    render json: @case_file
  end

  # GET /case_files/1/edit
  def edit
  end

  # POST /case_files
  # POST /case_files.json
  def create
    @case_file = CaseFile.new(case_file_params)

    respond_to do |format|
      if @case_file.save
        format.html { redirect_to @case_file, notice: 'Case file was successfully created.' }
        format.json { render :show, status: :created, location: @case_file }
      else
        format.html { render :new }
        format.json { render json: @case_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /case_files/1
  # PATCH/PUT /case_files/1.json
  def update
    respond_to do |format|
      if @case_file.update(case_file_params)
        format.html { redirect_to @case_file, notice: 'Case file was successfully updated.' }
        format.json { render :show, status: :ok, location: @case_file }
      else
        format.html { render :edit }
        format.json { render json: @case_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /case_files/1
  # DELETE /case_files/1.json
  def destroy
    @case_file.destroy
    respond_to do |format|
      format.html { redirect_to case_files_url, notice: 'Case file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case_file
      @case_file = CaseFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_file_params
      params.require(:case_file).permit(:urn, :blob)
    end
end

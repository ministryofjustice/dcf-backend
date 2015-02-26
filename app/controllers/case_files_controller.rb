class CaseFilesController < ApplicationController
  respond_to :json
  before_action :set_case_file, only: [:show, :edit, :update]

  # GET /case_files
  # GET /case_files.json
  def index
    require 'pp'
    @case_files = CaseFile.by_id
    respond_to do |format|
      format.json
    end
  end

  # GET /case_files/1
  # GET /case_files/1.json
  def show
    respond_to do |format|
      format.json
    end
  end

  # GET /case_files/new
  def new
    @case_file = CaseFile.new
    @case_file.save!
    respond_to do |format|
      format.json
    end
  end

  # GET /case_files/1/edit
  # def edit
  # end

  # POST /case_files
  # POST /case_files.json
  # def create
  #   @case_file = CaseFile.new(case_file_params)

  #   respond_to do |format|
  #     if @case_file.save
  #       format.html { redirect_to @case_file, notice: 'Case file was successfully created.' }
  #       format.json { render :show, status: :created, location: @case_file }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @case_file.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /case_files/1
  # PATCH/PUT /case_files/1.json
  def update
    @case_file.update_blob(params['case_file'])
    respond_to do |format|
      format.json
    end
  end

  # DELETE /case_files/1
  # DELETE /case_files/1.json
  def destroy
    @case_file = CaseFile.where(id: params[:id]).first
    if @case_file.nil?
      render json: "Record not found", status: 404
    else
      @case_file.destroy
      render json: "Record deleted"
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

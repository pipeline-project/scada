class PipelinesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /pipelines
  # GET /pipelines.json
  def index
    @pipelines &&= @pipelines.page(params[:page])
  end

  # GET /pipelines/1
  # GET /pipelines/1.json
  def show
  end

  # GET /pipelines/new
  def new
  end

  # GET /pipelines/1/edit
  def edit
  end

  # POST /pipelines
  # POST /pipelines.json
  def create
    respond_to do |format|
      if @pipeline.save
        format.html { redirect_to @pipeline, notice: 'Pipeline was successfully created.' }
        format.json { render :show, status: :created, location: @pipeline }
      else
        format.html { render :new }
        format.json { render json: @pipeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pipelines/1
  # PATCH/PUT /pipelines/1.json
  def update
    respond_to do |format|
      if @pipeline.update(pipeline_params)
        format.html { redirect_to @pipeline, notice: 'Pipeline was successfully updated.' }
        format.json { render :show, status: :ok, location: @pipeline }
      else
        format.html { render :edit }
        format.json { render json: @pipeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pipelines/1
  # DELETE /pipelines/1.json
  def destroy
    @pipeline.destroy
    respond_to do |format|
      format.html { redirect_to pipelines_url, notice: 'Pipeline was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def pipeline_params
    params.require(:pipeline).permit(:name, :description, steps_attributes: steps_params)
  end

  def steps_params
    [:id, :name, :type, *Step.all_stored_options]
  end
end

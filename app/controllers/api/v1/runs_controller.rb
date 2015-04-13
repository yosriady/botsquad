class API::V1::RunsController < API::BaseController
  before_action :set_run, only: [:show]
  before_action :authenticate

  # GET /runs
  def index
    @runs = Run.page(params[:page])
    render json: @runs
  end

  # GET /runs/1
  def show
    render json: @run
  end

  # POST /runs
  def create
    @run = Run.new(run_params)

    if @run.save
      render json: @run, status: 200, notice: 'Run was successfully updated.'
    else
      render status: 422
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find(params[:id])
    end
end

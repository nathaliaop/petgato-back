class ReportsController < ApplicationController
    include Paginable
    before_action :set_report, only: [:show, :update, :destroy]
    before_action :authorize_request, except: [:index, :show]
    before_action :authorize_request_admin, only: [:destroy]
  
    # GET /reports
    def index
      @reports = Report.page(current_page).per(per_page)
      render json: @reports
    end
  
    # GET /reports/1
    def show
      render json: @report
    end
  
    # POST /reports
    def create
      @report = Report.new(report_params)
  
      if @report.save
        render json: @report, status: :created
      else
        render json: @report.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /reports/1
    def update
      if @report.update(report_params)
        render json: @report
      else
        render json: @report.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /reports/1
    def destroy
      @report.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_report
        @report = Report.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def report_params
        params.permit(:reportable_type, :reportable_id)
      end
  end
  
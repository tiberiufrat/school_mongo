module Api
  module V1
    class SchoolsController < ApplicationController
      before_action :set_school, only: %i[show update destroy]
      before_action :authorize_access_request!, except: [:show, :index] # authorise the user before accessing this controller

      # GET /schools
      def index
        @schools = School.all

        render json: @schools
      end

      # GET /schools/1
      def show
        render json: @school
      end

      # POST /schools
      def create
        @school = School.new(school_params)

        if @school.save
          render json: @school, status: :created, location: @school
        else
          render json: @school.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /schools/1
      def update
        if @school.update(school_params)
          render json: @school
        else
          render json: @school.errors, status: :unprocessable_entity
        end
      end

      # DELETE /schools/1
      def destroy
        @school.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_school
        @school = School.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def school_params
        params.require(:school).permit(:name, :email, :phone, :country, :city, :address, :registration_code, :settings)
      end
    end
  end
end

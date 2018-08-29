class CohortsController < ApplicationController


  before_action :set_cohort, only: [:show, :edit, :update, :destroy]

  def new
    @cohort = Cohort.new
  end

  def create

    @cohort = Cohort.new(cohort_params)
    if @cohort.save
      respond_to do |format|
        format.html { redirect_to cohorts_url, notice: 'New COHORT CREATED' }
      end
    else
      render 'new'
    end
  end

  def edit
  end

  def show
     @cohort = Cohort.find(params[:id])
  end

  def index
    @cohorts = Cohort.all
  end

  def destroy
    @cohort.destroy
    respond_to do |format|
      format.html { redirect_to cohorts_url, notice: 'COHORTS HAS BEEN DESTROYED' }
    end
  end

  def update
    @cohort.update(cohort_params)
    respond_to do |format|
      format.html { redirect_to @cohort, notice: 'Cohort was successfully updated.' }
    end
  end

  private

  def set_cohort
    @cohort = Cohort.find(params[:id])
  end

  def cohort_params
    params.require(:cohort).permit(:name, :start_date, :end_date, :course)
  end

end

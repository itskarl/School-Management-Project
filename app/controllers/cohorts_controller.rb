class CohortsController < ApplicationController
  before_action :set_cohort, only: %i[show edit update destroy]

  def new
    @course = Course.find(params[:course_id]) if params[:course_id]
    @cohort = Cohort.new
  end

  def create
    @course = Course.find(params[:cohort][:course_id])
    @cohort = Cohort.new(cohort_params)
    @cohort.course_id = Course.find(params[:cohort][:course_id]).id

    if @cohort.save
      respond_to do |format|
        format.html { redirect_to course_cohort_path(@course.id,@cohort.id), notice: 'NEW COHORT CREATED' }
      end

    else
      render 'new'
    end
  end


  def edit; end

  def show
    @cohort.students << Student.find(params[:q][:student_ids]) if params[:q]
    @cohort = Cohort.find(params[:id])
    @cohort.students.delete(Student.find(params[:removestudent])) if params[:removestudent]
  end

  def index
    if params[:sort]
      @cohorts = Cohort.all.order("#{params[:sort]} ASC")
    else
      @cohorts = Cohort.all
    end
  end

  def destroy
    @cohort.destroy
    respond_to do |format|
      format.html { redirect_to cohorts_url, notice: 'COHORT HAS BEEN DESTROYED' }
        format.js {render :layout => false}
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
    params.require(:cohort).permit(:name, :start_date, :end_date, :course_id, :student_ids, :instructor_id)
  end
end

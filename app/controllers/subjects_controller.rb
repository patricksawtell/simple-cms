class SubjectsController < ApplicationController

  layout 'admin'
  
  before_action :confirm_logged_in

  before_action :set_subject_count, :only => [:new, :create, :edit, :update]

  def index
    #tells subject class to referance model scope :sorted and return array of the instance variable subjects.
    logger.debug("**** Testing the logger ****")
    @subjects = Subject.sorted
    
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => 'Default'})
  end

  def create
    # Instatiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save 
    # If save succeeds, redirect to index action
      flash[:notice] = "Subject created successfully!"
      redirect_to(subjects_path)
    else
    # If save fail, redisplay form template to user
    # Also set the subject_count before rerending 'new' template
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update 
    # Find a new object using form parameters
    @subject = Subject.find(params[:id])
    # Update the object 
    if @subject.update_attributes(subject_params)
      # If save succeeds, redirect to show action
      flash[:notice] = "Subject '#{@subject.name}' updated successfully!"
      redirect_to(subjects_path(@subject))
    else
      # If save fail, redisplay form template to user
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy 
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' destroyed successfully!"
    redirect_to(subjects_path)
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

  def set_subject_count
    @subject_count = Subject.count
    if params[:action] == 'new' || params[:action] == 'create'
      @subject_count += 1
    end
  end
end

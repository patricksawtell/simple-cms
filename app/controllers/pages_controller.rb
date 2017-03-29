class PagesController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_subject
  before_action :set_page_count, :only => [:new, :create, :edit, :update]

  def index
    @pages = @subject.pages.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(:subject_id => @subject.id)   
  end

  def create
    # 'X' which could represent an unecessary db call.
    @page = Page.new(page_params)
    @page.subject = @subject
    if @page.save
      flash[:notice] = "Page '#{@page.name}' created successfully!"
      redirect_to(pages_path(:subject_id => @subject.id))
    else
    
      # before_action :find_subjects hoists our original Subject.sorted to fire at the top of the action at 'X', regardless of save success/fail.  
      # @subjects = Subject.sorted
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page '#{@page.name}' updated successfully!"
      redirect_to(page_path(@page, :subject_id => @subject.id))
    else
      # @page_count = Page.count
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page '#{@page.name}' destroyed successfully!"
    redirect_to(pages_path(:subject_id => @subject.id))
  end

  

  private 

  def page_params
    params.require(:page).permit(:name, :position, :visible, :permalink)
  end


  def find_subject
    @subject = Subject.find(params[:subject_id])   
  end

  def set_page_count 
    #scoped page count by subject 
    @page_count = @subject.pages.count
    if params[:action] == 'new' || params[:action] == 'create'
      @page_count += 1
    end
  end
end

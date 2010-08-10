class ProblemsController < ApplicationController

  before_filter :authenticate_user!, :only => [:my, :ownership, :take_ownership, :update]

  def index
    @search = Search.new(params[:search])
    @problems = @search.results(:per_page => 10, :page => params[:page])
    @municipalities = Municipality.find :all, :select => "municipalities.id, municipalities.name, COUNT(*) as problems_count", :joins => :problems, :group => "municipalities.id", :limit => 10, :order => "problems_count DESC"
  end

  def ownership
    @problems = current_user.potentially_reported_problems
  end

  def take_ownership
    problems = Problem.find(params[:problem_ids].keys)
    current_user.take_ownership_of_problems(problems)
    redirect_to my_problems_url
  end

  def my
    @problems = current_user.problems.paginate :per_page => 10, :page => params[:page], :order => "id DESC"
  end

  def new
    @problem = Problem.new
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def edit
    @problem = Problem.find(params[:id])
  end

  def create
    @problem = Problem.new(params[:problem])

    @problem.user = current_user if user_signed_in? # assign current_user if user is logged in

    if (user_signed_in? || verify_recaptcha(:model => @problem, :message => "Грешка со reCAPTCHA")) && @problem.save
      flash[:notice] = 'Проблемот е успешно пријавен.'
      redirect_to @problem
    else
      render :action => :new
    end
  end

  def update
    @problem = Problem.find(params[:id])
    @problem.attributes = params[:problem]

    @problem.user = current_user

    if @problem.save
      flash[:notice] = 'Проблемот е успешно изменет.'
      redirect_to @problem
    else
      render :action => :new
    end
  end
end

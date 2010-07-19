class Api::V1::ProblemsController < ApplicationController

  layout false

  def index

    # TODO: implemented filters
    if params[:type] == "latest"
      problems = Problem.find(:all, :order => "problems.id DESC", :include => [:user, :category, :municipality], :limit => 4)
    elsif params[:type] == "nearest"
      problems = Problem.find(:all, :order => "problems.id DESC", :include => [:user, :category, :municipality], :limit => 5)
    elsif params[:type] == "my"
      problems = Problem.find(:all, :order => "problems.id DESC", :include => [:user, :category, :municipality], :limit => 6)
    else
      problems = Problem.find(:all, :order => "problems.id DESC", :include => [:user, :category, :municipality], :limit => 7)
    end

    @problems = []
    problems.each do |problem|
      @problems << {
        :id => problem.id,
        :description => problem.description,
        :longitude => problem.longitude,
        :latitude => problem.latitude,
        :category => problem.category.try(:name),
        :municipality => problem.municipality.try(:name),
        :user_name => problem.user.try(:name) || problem.name,
        :photo => problem.photo.url(:s),
        :created_at => problem.created_at.to_s(:rfc822) #problem.created_at.strftime("%b %d, %Y %H:%M:%S")
      }
    end

    respond_to do |format|
      format.json { render :json => @problems.to_json }
    end
  end

  def create
    @problem = Problem.new(params[:problem])

    if @problem.save
      respond_to do |format|
        format.json { render :json => {:status => "ok", :id => @problem.id}.to_json }
      end
    else
      respond_to do |format|
        format.json { render :json => {:status => "error"}.to_json }
      end
    end
  end

  def update
    #File.open('t.jpg', "wb") { |f| f.write(params['media'].read) }
    @problem = Problem.find(params[:id])

    device_id = params[:device_id].read

    # if photo is submitted from the same device
    if @problem.device_id == device_id
      @problem.photo = params[:photo]

      if @problem.save
        respond_to do |format|
          format.json { render :json => {:status => "ok"}.to_json }
        end
      else
        respond_to do |format|
          format.json { render :json => {:status => "error", :type => "photo"}.to_json }
        end
      end
    else
      respond_to do |format|
        format.json { render :json => {:status => "error", :type => "device_id"}.to_json }
      end
    end
  end
end

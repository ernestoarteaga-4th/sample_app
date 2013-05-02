class TagsController < ApplicationController
  def index
    @tags = Tag.paginate(:page => params[:page], 
                         :per_page => 20)
  end

  def new

  end

  def create
    @tag = Tag.new(params[:tag])

    if(@tag.name.strip == "" || @tag.type_tag.to_i == 0)
      flash[:notice] = "The tag has empty elements"
    else
      @tag.save
    end

    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/tags')
  end

  def edit
    @tag = Tag.new(:id => params[:id],
                   :name => params[:name],
                   :type_tag => params[:type_tag],
                   :description => params[:description])
  end

  def destroy
    Tag.delete(params[:id])
    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/tags')
  end

  def action
    @tag = Tag.new(params[:tag])

    if(params[:update_button] != nil)
        Tag.update(@tag.id, 
                   :name => @tag.name,
                   :description => @tag.description,
                   :type_tag => @tag.type_tag)
    else
        Tag.delete(@tag.id)
    end

    redirect_to File.join('/staff/', current_candidate.id.to_s(), '/tags')
  end
end
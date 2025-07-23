class FoldersController < ApplicationController
  before_action :set_folder, only: [ :show, :edit, :update, :destroy ]

  def show
  end

  def new
    @folder = Folder.new
  end

  def edit
  end

  def create
    @folder = current_team.folders.new(folder_params)

    respond_to do |format|
      if @folder.save
        format.turbo_stream {
          flash[:notice] = t(".created")
          render turbo_stream: turbo_stream.action(:redirect, folder_path(@folder))
        }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("folder-form", partial: "folders/form", locals: { folder: @folder }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.turbo_stream {
          flash[:notice] = t(".updated")
          render turbo_stream: turbo_stream.action(:redirect, folder_path(@folder))
        }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("folder-form", partial: "folders/form", locals: { folder: @folder }) }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @folder.destroy

    redirect_to root_path, notice: t(".deleted")
  end

  private

  def folder_params
    params.expect(folder: [ :name ])
  end

  def set_folder
    @folder = current_team.folders.find_by(slug: params[:slug])
  end
end

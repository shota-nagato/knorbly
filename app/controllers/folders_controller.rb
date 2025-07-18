class FoldersController < ApplicationController
  def show
    @folder = current_user.teams.last.folders.find_by(slug: params[:slug])
  end

  def new
    @folder = Folder.new
  end

  def create
    @folder = current_user.teams.last.folders.new(folder_params)

    respond_to do |format|
      if @folder.save
        format.turbo_stream {
          flash[:notice] = "フォルダを作成しました"
          render turbo_stream: turbo_stream.action(:redirect, folder_path(@folder))
        }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("folder-form", partial: "folders/form", locals: { folder: @folder }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def folder_params
    params.expect(folder: [ :name ])
  end
end

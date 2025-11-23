class Admin::SourcesController < Admin::ApplicationController
  before_action :set_source, only: %i[ show edit update ]

  def index
    @sources = Source.order(created_at: :desc)
  end

  def show
  end

  def new
    @source = Source.new
  end

  def edit
  end

  def create
    @source = Source.new(source_params)

    if @source.save
      redirect_to admin_source_path(@source), notice: "ソースを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @source.update(source_params)
      redirect_to admin_source_path(@source), notice: "ソースを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_source
    @source = Source.find_by(slug: params[:id])
  end

  def source_params
    params.expect(source: [ :name, :slug, :description, :url, :source_type, :rss_url ])
  end
end

class CatsController < ApplicationController
  before_action :set_cat, only: %i[ show edit update destroy ]

  # GET /cats or /cats.json
  def index
    @search = Cat.ransack(params[:q])
    @search.sorts = "id desc" if @search.sorts.empty?
    @cats = @search.result.page(params[:page])
  end

  # GET /cats/1 or /cats/1.json
  def show
  end

  # GET /cats/new
  def new
    @cat = Cat.new
  end

  # GET /cats/1/edit
  def edit
  end

  # POST /cats or /cats.json
  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      flash.now.notice = "ねこを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cats/1 or /cats/1.json
  def update
    if @cat.update(cat_params)
      flash.now.notice = "ねこを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /cats/1 or /cats/1.json
  def destroy
    @cat.destroy!

    respond_to do |format|
      format.html { redirect_to cats_path, status: :see_other, notice: "Cat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cat
      @cat = Cat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cat_params
      params.require(:cat).permit(:name, :age)
    end
end

class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  # GET /products or /products.json
  def index
    @products = Product.all
    #categoria
    if params[:category_id]
      @products = @products.where(category_id: params[:category_id])
    end
    #min_price, ahora estan nill o nulos ya que no se le ha ingresado números
    if params[:min_price].present? 
      @products = @products.where('price >= ?', params[:min_price].to_i)
    end

    if params[:max_price].present? 
      @products = @products.where('price <= ?', params[:max_price].to_i)
    end

    if params[:room] && params[:room].to_i !=0
      @products = @products.where(room: params[:room].to_i)
    end 

    if params[:bathroom] && params[:bathroom].to_i != 0
      @products = @products.where(bathroom: params[:bathroom].to_i)
    end

  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:category_id, :name, :room, :bathroom, :price,:photo ,:body,images: [])

    end

    
end

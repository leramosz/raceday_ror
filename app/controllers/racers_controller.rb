class RacersController < ApplicationController
  before_action :set_racer, only: [:show, :edit, :update, :destroy]

  # GET /racers
  # GET /racers.json
  def index
    #@racers = Racer.all
    #@racers = Racer.paginate(params)

    args=params.clone                      #update a clone of params
    args[:sort]=get_sort_hash(args[:sort]) #replace sort with hash
    #@racers = Racer.all
    @racers = Racer.paginate(page:params[:page], per_page:params[:per_page])
  end

  # GET /racers/1
  # GET /racers/1.json
  def show
  end

  # GET /racers/new
  def new
    @racer = Racer.new
  end

  # GET /racers/1/edit
  def edit
  end

  # POST /racers
  # POST /racers.json
  def create
    @racer = Racer.new(racer_params)

    respond_to do |format|
      if @racer.save
        format.html { redirect_to @racer, notice: 'Racer was successfully created.' }
        format.json { render :show, status: :created, location: @racer }
      else
        format.html { render :new }
        format.json { render json: @racer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /racers/1
  # PATCH/PUT /racers/1.json
  def update
    respond_to do |format|
      if @racer.update(racer_params)
        format.html { redirect_to @racer, notice: 'Racer was successfully updated.' }
        format.json { render :show, status: :ok, location: @racer }
      else
        format.html { render :edit }
        format.json { render json: @racer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /racers/1
  # DELETE /racers/1.json
  def destroy
    @racer.destroy
    respond_to do |format|
      format.html { redirect_to racers_url, notice: 'Racer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_racer
      @racer = Racer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def racer_params
      params.require(:racer).permit(:id, :number, :first_name, :last_name, :gender, :group, :secs)
    end

    #create a hash sort spec from query param
    def get_sort_hash(sort)
      order={}
      if (!sort.nil?)
        sort.split(",").each do |term|
          args=term.split(":")
          dir = args.length<2 || args[1].to_i >= 0 ? 1 : -1
          order[args[0]] = dir
        end
      end
      return order
    end
end

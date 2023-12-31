class PlayersController < ApplicationController
  include Filterable
  before_action :set_player, only: %i[ show edit update destroy disable_modal ]

  # GET /players or /players.json
  def index
    @pagy, @players = pagy( Player.all )
  end

  def list
    filter = filter!(Player)
    @pagy, @players = pagy( filter )
    render(partial: 'players_table', locals: { players: filter })
  end

  # GET /players/1 or /players/1.json
  def show
    flash[:notice] = 'Just testing, dude'
  end

  # GET /players/new
  def new
    @player = Player.new
    @teams = Team.all
  end

  # GET /players/1/edit
  def edit
    @teams = Team.all
  end

  # POST /players or /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        flash.now[:notice] = "Jugador registrado"
        format.turbo_stream { render turbo_stream: [
          turbo_stream.prepend( "players_table_body", partial: "players/player", locals: {player: @player} ),
          turbo_stream.replace( "notifications", partial: "shared/notifications")
        ] }
        format.html { redirect_to player_url(@player), notice: "Player was successfully created." }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        flash.now[:notice] = "Datos del jugador actualizados"
        format.turbo_stream { render turbo_stream: [
          turbo_stream.replace( @player, @player ),
          turbo_stream.replace( "notifications", partial: "shared/notifications")
        ] }
        format.html { redirect_to player_url(@player), notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable_modal;end

  # DELETE /players/1 or /players/1.json
  def destroy
    @player.destroy!
    flash.now[:notice] = "Jugador eliminado"
    respond_to do |format|
      format.turbo_stream { render turbo_stream: [
        turbo_stream.remove( @player ),
      turbo_stream.replace( "notifications", partial: "shared/notifications") 
      ] }
      format.html { redirect_to players_url, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:name, :team_id, :seasons)
    end
end

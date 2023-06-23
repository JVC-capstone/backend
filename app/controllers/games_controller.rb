class GamesController < ApplicationController
    def index
        games = Game.all 
        render json: games
    end

    def show 
        game = Game.find(params[:id])
        render json: game
    end

    def create 
        game = Game.create(game_params)
        if game.valid?
            render json: game
        else
            render json: game.errors, status: 422
        end
    end

    def update
      
      end

      def destroy

      end

    private
    def game_params
        params.require(:game).permit(:title, :image, :platform, :genre, :notes, :user_id)
    end
end

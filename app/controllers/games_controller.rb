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
          render json: game.errors
        end
      end

    def update
        game = Game.find(params[:id])
        if game.update(game_params)
        
          render json: game
        else
          render json: game.errors, status: 422
        end
   
    end

    def destroy
        game = Game.find(params[:id])
        games = Game.all
        if game.destroy
          render json: games, status: 410
        else
          render json: game.errors
        end
    end

    private
    def game_params
        params.require(:game).permit(:title, :image, :platform, :genre, :notes, :user_id)
    end
end





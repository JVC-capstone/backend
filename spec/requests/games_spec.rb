require 'rails_helper'

RSpec.describe "Games", type: :request do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }

  describe "GET /index" do
    it 'gets a list of games' do
      game = user.games.create(
        title: 'THE LEGEND OF ZELDA: TEARS OF THE KINGDOM',
        image: 'https://media.rawg.io/media/resize/420/-/screenshots/c0d/c0dafd15ec182acab8f5879665eaa642.jpg',
        platform: 'Nintendo Switch',
        genre: 'Adventure',
        notes: 'Some good action in this game'
      )
      get '/games'
      game = Game.first
      expect(response).to have_http_status(200)
      expect(game['title']).to eq('THE LEGEND OF ZELDA: TEARS OF THE KINGDOM')
    end
  end

  describe "POST /create" do
    it "creates a game with all its attributes" do
      game_params = {
        game: {
          title:'Vectorman',
          image:'https://upload.wikimedia.org/wikipedia/en/4/43/Vectorman_cover.jpg?20080627132115',
          platform:'Sega Genesis',
          genre:'Adventure',
          notes:'Awesome childhood game!',
          user_id: user.id
        }
      }
      post '/games', params: game_params
      game = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      games = Game.all
      expect(games.length).to be(1)
    end

    it "doesn't create an apartment without a street" do
      game_params = {
        game: {
          title: nil,
          image:'https://upload.wikimedia.org/wikipedia/en/4/43/Vectorman_cover.jpg?20080627132115',
          platform:'Sega Genesis',
          genre:'Adventure',
          notes:'Awesome childhood game!',
          user_id: user.id
        }
      }
      post '/games', params: game_params
      game = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(game['title']).to include("can't be blank")
    end
  end

  describe "PATCH /update" do
    it "updates a game with valid attributes" do
      game = user.games.create(
        title: 'Vectorman',
        image:'https://upload.wikimedia.org/wikipedia/en/4/43/Vectorman_cover.jpg?20080627132115',
        platform:'Sega Genesis',
        genre:'Adventure',
        notes:'Awesome childhood game!',
        user_id: user.id
      )
      get '/games'

      game1 = Game.first
      game_params = {
        game: {
          title: 'Vector-man',
          image:'https://upload.wikimedia.org/wikipedia/en/4/43/Vectorman_cover.jpg?20080627132115',
          platform:'SEGA',
          genre:'Action',
          notes:'Awesome childhood game spent many hours on this game!',
          user_id: user.id
        }
      }
      patch "/games/#{game1.id}", params: game_params
      game = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(game['title']).to eq('Vector-man')
    end

    it "doesn't update a game without a title" do
      game = user.games.create(
        title: 'Vector-man',
        image:'https://upload.wikimedia.org/wikipedia/en/4/43/Vectorman_cover.jpg?20080627132115',
        platform:'SEGA',
        genre:'Action',
        notes:'Awesome childhood game spent many hours on this game!',
        user_id: user.id
      )
      get '/games'

      game1 = Game.first
      game_params = {
        game: {
          title: nil,
          image:'https://upload.wikimedia.org/wikipedia/en/4/43/Vectorman_cover.jpg?20080627132115',
          platform:'SEGA',
          genre:'Action',
          notes:'Awesome childhood game spent many hours on this game!',
          user_id: user.id
        }
      }
      patch "/games/#{game1.id}", params: game_params
      game = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(game['title']).to include("can't be blank")
    end
  end

  describe "DELETE /destroy" do
    it "deletes a game with a valid id params" do
      gametitle1 = user.games.create(
        title: 'Vector-man',
        image:'https://upload.wikimedia.org/wikipedia/en/4/43/Vectorman_cover.jpg?20080627132115',
        platform:'SEGA',
        genre:'Action',
        notes:'Awesome childhood game spent many hours on this game!',
        user_id: user.id
      )

      gametitle2 = user.games.create(
        title: 'Vectorman',
        image:'https://upload.wikimedia.org/wikipedia/en/4/43/Vectorman_cover.jpg?20080627132115',
        platform:'SEGA Genesis',
        genre:'Adventure',
        notes:'Spent many hours on this game!',
        user_id: user.id
      )
      get '/games'

      expect(Game.count).to eq(2)
      game1 = Game.first
      delete "/games/#{game1.id}"
      expect(response).to have_http_status(410)
      expect(Game.count).to eq(1)
    end
  end
end
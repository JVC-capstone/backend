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
      expect(response).to have_http_status(200)
      games = Game.all
      expect(games.length).to be(1)
    end
  end
end
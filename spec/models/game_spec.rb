require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }

  it 'should validate title' do
    game = user.games.create(
      title: nil,
      image: 'https://media.rawg.io/media/resize/420/-/screenshots/c0d/c0dafd15ec182acab8f5879665eaa642.jpg',
      platform: 'Nintendo Switch',
      genre: 'Adventure',
      notes: 'Some good action in this game'
    )
    expect(game.errors[:title]).to_not be_empty
  end
  
  it 'should validate an image' do
    game = user.games.create(
      title: 'THE LEGEND OF ZELDA: TEARS OF THE KINGDOM',
      image: nil,
      platform: 'Nintendo Switch',
      genre: 'Adventure',
      notes: 'Some good action in this game'
    )
    expect(game.errors[:image]).to_not be_empty
  end
 
  it 'should validate a platform' do
    game = user.games.create(
      title: 'THE LEGEND OF ZELDA: TEARS OF THE KINGDOM',
      image: 'https://media.rawg.io/media/resize/420/-/screenshots/c0d/c0dafd15ec182acab8f5879665eaa642.jpg',
      platform: nil,
      genre: 'Adventure',
      notes: 'Some good action in this game'
    )
    expect(game.errors[:platform]).to_not be_empty
  end
   
  it 'should validate a genre is present' do
    game = user.games.create(
      title: 'THE LEGEND OF ZELDA: TEARS OF THE KINGDOM',
      image: 'https://media.rawg.io/media/resize/420/-/screenshots/c0d/c0dafd15ec182acab8f5879665eaa642.jpg',
      platform: 'Nintendo Switch',
      genre: nil,
      notes: 'Some good action in this game'
    )
    expect(game.errors[:genre]).to_not be_empty
  end

  it 'should validate notes are present' do
    game = user.games.create(
      title: 'THE LEGEND OF ZELDA: TEARS OF THE KINGDOM',
      image: 'https://media.rawg.io/media/resize/420/-/screenshots/c0d/c0dafd15ec182acab8f5879665eaa642.jpg',
      platform: 'Nintendo Switch',
      genre: 'Adventure',
      notes: nil
    )
    expect(game.errors[:notes]).to_not be_empty
  end
  
end 

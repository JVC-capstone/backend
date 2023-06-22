# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")


games = [
    {
        title:"THE LEGEND OF ZELDA: TEARS OF THE KINGDOM",
        image:"https://media.rawg.io/media/resize/420/-/screenshots/c0d/c0dafd15ec182acab8f5879665eaa642.jpg",
        platform:"Nintendo Switch",
        genre:"Adventure",
        notes:"Fun game! Spend alot of hours trying to beat it." 
},
  {
        title:"THE WITCHER 3: WILD HUNT",
        image:"https://media.rawg.io/media/resize/420/-/screenshots/f63/f6373ee614046d81503d63f167181803.jpg",
        platform:"PlayStation 5",
        genre:"RPG",
        notes:"Open world adventures of the renowned monster slayer Geralt of Rivia are now even on a larger scale."  
},
  {
        title:"Marvel's Spider-Man 2",
        image:"https://media.rawg.io/media/resize/640/-/screenshots/89b/89b077deb2a3ce38e071fdb5caae69c0.jpg",
        platform:"PlayStation 5",
        genre:"Action",
        notes:"This is my wishlist game!"
},
{
        title:"Skull & Bones",
        image:"https://media.rawg.io/media/resize/420/-/screenshots/bdf/bdf42d2db7c40744da3d62407e16fdcb.jpg",
        platform:"Xbox Series S/X",
        genre:"Action",
        notes:"It is the Golden Age of Piracy. Renegade captains command the most powerful weapons on Earth: warships."
}
]


games.each do |game|
    user1.games.create(game)
    p "creating: #{game}"
  end
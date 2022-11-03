class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end
  delete '/games/:id' do
    game = Game.find(params[:id])
    game.destroy
    game.to_json
  end

  post '/games' do
    game = Game.create(params)
    games = Game.all
    games.to_json
  end


  patch '/games/:id' do
    game = Game.find(params[:id])
    game.update(params)
    game.to_json
  end



  

end

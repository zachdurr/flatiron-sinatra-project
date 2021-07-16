class PlayersController < ApplicationController

    get '/players/new' do
        if logged_in?
          erb :'/players/new_player'
        else
          erb :index
        end
    end
      
    post '/players' do
        if !params[:name].empty? && !params[:position].empty?
          @player = Player.create(params)
          @player.save
          binding.pry
          current_team.players << @player
          redirect to "/teams/#{current_team.id}"
        else
          redirect to '/players/new'
        end
    end

    get '/players/:id' do
        @player = Player.find_by_id(params[:id])
        erb :'/players/show_player'
    end

    get '/players/:id/edit' do
        if logged_in?
            @player = Player.find_by(params[:id])
            erb :'/players/edit_player'
        else
            redirect to '/login'
        end
    end

    patch '/players/:id' do
        if logged_in?
            if params[:name] == "" || params[:position] == ""
                redirect to "/tweets/#{params[:id]}/edit"
            else
                @player = Player.find_by_id(params[:id])
                    if @player.update(name: params[:name]) && @player.update(position: params[:position])
                        redirect to "/players/#{@player.id}"
                    else
                        redirect to "/players/#{@player.id}/edit"
                    end
            end
        else
            redirect to '/login'
        end
    end


    delete '/players/:id/delete' do
        if logged_in?
          @player = Player.find_by_id(params[:id])
          if @player.team == current_team
            @player.delete
            redirect to "/teams/#{current_team.id}"
          else
            redirect to "/teams/#{current_team.id}"
          end
        else
          erb :index
        end
    end

end

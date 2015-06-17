require "sinatra"

get "/" do	
	erb :index
end

get "/hola/:nombre" do
	params[:nombre]
end

not_found do
	status 404
	"Error 404, dirección no encontrada"
end
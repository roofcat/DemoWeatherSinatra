require "rubygems"
require "sinatra"
require "net/http"
require "json"

baseurl = "https://query.yahooapis.com/v1/public/yql?"
yql_query = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text in ('Santiago, Chile', 'Buenos Aires, Argentina', 'Lima, Peru', 'New York, USA', 'Toronto, Canada'))"

get "/" do
	uri = URI(baseurl)
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	params = { :q => yql_query, :format => 'json'}
	uri.query = URI.encode_www_form(params)
	res = http.get(uri.request_uri)
	data = JSON.parse(res.body)
	@climas = data['query']['results']['channel']
	erb :index
end

not_found do
	status 404
	"Error 404, dirección no encontrada"
end
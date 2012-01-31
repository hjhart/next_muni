require 'rubygems'
require 'next_muni'
require 'sinatra'
require 'yaml'
require 'awesome_print'

get '/buses' do
  @routes = NextMuni.get_routes('sf-muni')
  erb :buses
end

post '/add' do
  pages = YAML.load(File.open('buses.yml', 'r').read)
  params[:bus]
  params[:bus_stop]
  params[:page]
  
  "#{params[:page]} on bus #{params[:bus]} with stop #{params[:bus_stop]}"

  page = pages.select { |page| page[:label] == params[:page] }
  return "Error saving the page" if page.empty?
  
  buses = page.first[:buses]
  buses << {
    :label => params[:label],
    :stop => params[:bus_stop],
    :bus => params[:bus]
  }
  
  File.open('buses.yml', 'w') { |f| f.puts pages.to_yaml }
  redirect "/#{params[:page]}"
end

get '/bus/:bus_no' do
  @bus = params[:bus_no]
  @directions = NextMuni.get_stops(@bus)
  erb :add
end

get '/bus/:bus_no/:bus_stop' do
  @bus = params[:bus_no]
  @bus_stop = params[:bus_stop]
  @times = NextMuni.get_times(@bus, @bus_stop)
  pages = YAML.load(File.open('buses.yml', 'r').read)
  @links = pages.map { |page| page[:label] }
  erb :times
end

get '/:name' do
  pages = YAML.load(File.open('buses.yml', 'r').read)  
  page = pages.select { |page| page[:label] == params[:name] }
  if page.empty?
    "Page not found" 
  else
    page = page.first
    @stops = page[:buses].map do |bus|
      {
      :bus => bus[:label],
      :times => NextMuni.get_times(bus[:bus].to_s, bus[:stop])
      }
    end
    @links = pages.map { |page| page[:label] }
    erb :stops
  end
end

get '/' do
  pages = YAML.load(File.open('buses.yml', 'r').read)  
  redirect "/#{pages.first[:label]}"
end


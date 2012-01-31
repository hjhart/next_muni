require 'rubygems'
require 'next_muni'
require 'sinatra'

get '/' do
  @stops = [
    {
     :bus => "38BX",
     :times => NextMuni.get_times("38BX", 4347)
  },
  {
     :bus => "31BX",
     :times => NextMuni.get_times("31BX", 4347)
  },
  {
     :bus => "38L",
     :times => NextMuni.get_times("38L", 4725)
  },
  {
     :bus => "38 @ Main/Howard",
     :times => NextMuni.get_times("38", 7620)
     
  },
  ]
  
  erb :stops
end

get '/work' do
  @stops = [
    {
     :bus => "38L",
     :times => NextMuni.get_times("38L", 4759)
  },
    {
     :bus => "38",
     :times => NextMuni.get_times("38", 4759)
  },
    {
     :bus => "43",
     :times => NextMuni.get_times("43", 6092)
  },
  {
     :bus => "31BX",
     :times => NextMuni.get_times("31BX", 6092)
  },
  {
     :bus => "38BX",
     :times => NextMuni.get_times("38BX", 6092)
  }
  ]
  
  erb :stops
end

  
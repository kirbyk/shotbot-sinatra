require 'sinatra'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'foo.sqlite3'
)

class Drink < ActiveRecord::Base
  def ingredients
    8.times do |i|
      id_str = "ingredient_name_#{i+1}"
      if !id_str.nil?
        id = self.send(id_str)
        ing_name = Ingredient.find(id).name unless id.nil?
        vol = self.send("ingredient_volume_#{i+1}")
        map[id] = vol unless id.nil?
      end
    end
  end

  def render_code
    map = {}
    8.times do |i|
      id = self.send("ingredient_name_#{i+1}")
      vol = self.send("ingredient_volume_#{i+1}")
      map[id] = vol unless id.nil?
    end
    hash_to_str(map)
  end

  private
  def hash_to_str hash
    str = '00000000'
    hash.each do |key, val|
      index = key.to_i - 1
      char = val.to_s[0]
      str[index] = char
    end
    str
  end
end

class Ingredient < ActiveRecord::Base
end

get '/' do
  @drinks = Drink.all
  erb :index
end

get '/drink/:id/make' do
  @drink = Drink.find(params['id'])
  `echo '#{@drink.render_code}' | nc 192.168.10.61 9999 > /dev/null &`
  'Your shot is being poured...'
end

get '/test' do
  @drink = Drink.first
  @drink.ingredients
end

get '/drink/:id' do
  @drink = Drink.find(params['id'])
  erb :drink_show
end

get '/create_ingredients' do
  Ingredient.create(name: 'Red')
  Ingredient.create(name: 'Blue')
  Ingredient.create(name: 'Green')
  Ingredient.create(name: 'Yellow')
  Ingredient.create(name: 'Orange')
  Ingredient.create(name: 'Clear')
  Ingredient.create(name: 'Purple')
  Ingredient.create(name: 'White')
end

get '/create_drinks' do
  Drink.create(name: 'Baltimore Zoo', ingredient_name_1: 2, ingredient_volume_1: 2, ingredient_name_2: 4, ingredient_volume_2: 3)
  Drink.create(name: 'Green Dragon', ingredient_name_1: 1, ingredient_volume_1: 1, ingredient_name_2: 2, ingredient_volume_2: 1)
  Drink.create(name: 'Boilermaker', ingredient_name_1: 2, ingredient_volume_1: 2, ingredient_name_2: 6, ingredient_volume_2: 2)
  Drink.create(name: 'Jungle Juice', ingredient_name_1: 3, ingredient_volume_1: 2, ingredient_name_2: 1, ingredient_volume_2: 1)
  Drink.create(name: 'Screwdriver', ingredient_name_1: 4, ingredient_volume_1: 1, ingredient_name_2: 6, ingredient_volume_2: 1)
  Drink.create(name: 'Manhattan', ingredient_name_1: 5, ingredient_volume_1: 3, ingredient_name_2: 5, ingredient_volume_2: 2)
  Drink.create(name: 'Mimosa', ingredient_name_1: 6, ingredient_volume_1: 1, ingredient_name_2: 7, ingredient_volume_2: 2)
  Drink.create(name: 'Fuzzy Naval', ingredient_name_1: 7, ingredient_volume_1: 1, ingredient_name_2: 6, ingredient_volume_2: 2)
  Drink.create(name: 'Bloody Mary', ingredient_name_1: 8, ingredient_volume_1: 1, ingredient_name_2: 5, ingredient_volume_2: 1)
  Drink.create(name: 'Caribou Lou', ingredient_name_1: 1, ingredient_volume_1: 1, ingredient_name_2: 4, ingredient_volume_2: 3)
  Drink.create(name: 'Finding Nemo', ingredient_name_1: 2, ingredient_volume_1: 3, ingredient_name_2: 7, ingredient_volume_2: 2)
  Drink.create(name: 'Harvey Wallbanger', ingredient_name_1: 3, ingredient_volume_1: 3, ingredient_name_2: 1, ingredient_volume_2: 1)
  Drink.create(name: 'Kamikaze', ingredient_name_1: 4, ingredient_volume_1: 3, ingredient_name_2: 3, ingredient_volume_2: 1)
  Drink.create(name: 'Sangria', ingredient_name_1: 5, ingredient_volume_1: 1, ingredient_name_2: 3, ingredient_volume_2: 2)
  Drink.create(name: 'Sex on the Beach', ingredient_name_1: 6, ingredient_volume_1: 3, ingredient_name_2: 3, ingredient_volume_2: 3)
  Drink.create(name: 'Daiquiri', ingredient_name_1: 7, ingredient_volume_1: 2, ingredient_name_2: 8, ingredient_volume_2: 2)
  Drink.create(name: 'White Russian', ingredient_name_1: 8, ingredient_volume_1: 2, ingredient_name_2: 4, ingredient_volume_2: 2)
  Drink.create(name: 'Zombie', ingredient_name_1: 3, ingredient_volume_1: 3, ingredient_name_2: 4, ingredient_volume_2: 3)
end

get '/destory_ingredients' do
  Ingredient.destroy_all
end

get '/destory_drinks' do
  Drink.destroy_all
end

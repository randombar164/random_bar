require 'csv'
require 'active_support'

namespace :dbm do

  desc "マスターデータを保存するrakeタスク"
  task :create_master => :environment do
    p "なす"
    CSV.read("./lib/tasks/main.csv").each_with_index do |row, ri|
      p ri
      drink_name, method_name, type_name, ingredient_name, additional_explanation, amount, unit_name, cook_explanation, strength = row[0], row[1], row[2], row[3], row[4], row[5].to_f, row[6], row[7], row[8].to_f
      p row
      # あるか探す
      base_drink = BaseDrink.find_by(name: drink_name, strength: strength)
      drink_method = DrinkMethod.find_by(name: method_name)
      glass_type = GlassType.find_by(name: type_name)
      base_ingredient = BaseIngredient.find_by(name: ingredient_name)
      unit = Unit.find_by(name: unit_name)
      # なかったら作る
      drink_method = DrinkMethod.create(name: method_name) if drink_method.nil?
      glass_type = GlassType.create(name: type_name) if glass_type.nil?
      unit = Unit.create(name: unit_name) if unit.nil?
      base_drink = BaseDrink.create(name: drink_name, drink_method_id: drink_method.id, glass_type_id: glass_type.id, strength: strength, cook_explanation: cook_explanation) if base_drink.nil?
      base_ingredient = BaseIngredient.create(name: ingredient_name) if base_ingredient.nil?

      begin
        BaseDrinksBaseIngredient.create(base_ingredient_id: base_ingredient.id, base_drink_id: base_drink.id, amount: amount, additional_explanation: additional_explanation, unit_id: unit.id)
      rescue => e
        p e
      end

    end
    CSV.read("./lib/tasks/concrete_ingredients.csv").each_with_index do |row, ri|
      p ri
      base_ingredient_id, name, url = row[0].to_i, row[1], row[2]
      p row
      ConcreteIngredient.create(base_ingredient_id: base_ingredient_id, name: name, url: url)
    end

    CSV.read("./lib/tasks/handling_stores.csv").each_with_index do |row, ri|
      p ri
      name = row[0]
      p row
      HandlingStore.create(name: name)
    end

    CSV.read("./lib/tasks/concrete_ingredients_handling_stores.csv").each_with_index do |row, ri|
      p ri
      concrete_ingredient_id, handling_store_id = row[0].to_i, row[1].to_i
      p row
      ConcreteIngredientsHandlingStore.create(concrete_ingredient_id: concrete_ingredient_id, handling_store_id: handling_store_id)
    end

    CSV.read("./lib/tasks/substitutions.csv").each_with_index do |row, ri|
      p ri
      substituted_id, substituting_id = row[0].to_i, row[1].to_i
      p row
      Substitution.create(substituted_id: substituted_id, substituting_id: substituting_id)
    end

  end

end

class BaseDrink < ApplicationRecord
  belongs_to :drink_method
  belongs_to :glass_type
  has_many :base_drinks_base_ingredients
  has_many :base_ingredients, through: :base_drinks_base_ingredients

  def self.find_by_params params
    params_base_drink_id_present?(params) ? \
      BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find(params[:base_drink_id]) : \
      BaseDrink.get_random(params[:filters])
  end

  def self.params_base_drink_id_present? params
    if params[:base_drink_id].blank? || ![*1..BaseDrink.count].include?(params[:base_drink_id]&.to_i)
      params.delete(:concrete_ingredients)
      params.delete(:base_drink_id)
    end
    return false if params[:base_drink_id].nil?
    params.delete(:filters)
    return true
  end

  def self.get_random params_filters
    return BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find(rand(1..BaseDrink.count)) if params_filters.nil?
    if params_filters[:base_ingredient_ids].blank?
      base_drink_ids = [*1..BaseDrink.last.id]
    else
      params_base_ingredient_ids = params_filters[:base_ingredient_ids].values.map(&:to_i)
      base_drink_ids = BaseDrinksBaseIngredient.get_base_drink_ids_from_base_ingredient_ids(params_base_ingredient_ids)
    end
    return nil if base_drink_ids.empty?
    base_drink = BaseDrink.base_drink_from_handling_stores(base_drink_ids, Array(params_base_ingredient_ids), params_filters[:handling_store_ids]&.values&.map(&:to_i))
    return base_drink
  end

  def self.base_drink_from_handling_stores(bd_ids, bi_ids, handling_store_ids)
    handling_store_ids ||= [1,2,3]
    bi_ids.each do |bi_id|
      BaseIngredient.find(bi_id).concrete_ingredients.each do |ci|
        return nil if (handling_store_ids - ci.handling_store_ids).length == handling_store_ids.length
      end
    end
    bd_ids.shuffle!
    bd_ids.each do |base_drink_id|
      base_drink = BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find(base_drink_id)
      return base_drink if base_drink.check_enough_base_ingredients?(handling_store_ids)
    end
    return nil
  end

  def check_enough_base_ingredients?(handling_store_ids)
    self.base_ingredients.each do |base_ingredient|
      return false if (handling_store_ids - base_ingredient.handling_store_ids_without_unavailable).length == handling_store_ids.length
    end
    return true
  end

  def concrete_ingredients params
    params_concrete_ingredients_valid?(params) ? \
      self.get_concrete_ingredients_from_params(params[:concrete_ingredients]) : \
      self.get_random_concrete_ingredients(params[:filters])
  end

  def params_concrete_ingredients_valid? params
    return false if params[:concrete_ingredients].nil?
    return false unless check_params_base_ingredient_ids_with_concrete_ingredient_ids params
    return false if !self.check_params_base_ingredient_ids(params) && !self.check_substitutions(params)
    return true
  end

  def check_params_base_ingredient_ids_with_concrete_ingredient_ids params
    params[:concrete_ingredients].values.each do |concrete_ingredient|
      return false if concrete_ingredient[:base_ingredient_id].nil? || concrete_ingredient[:concrete_ingredient_id].nil?
      return false if concrete_ingredient[:base_ingredient_id].to_i != ConcreteIngredient.find(concrete_ingredient[:concrete_ingredient_id]).base_ingredient_id
    end
    return true
  end

  def check_params_base_ingredient_ids params
    params_base_ingredient_ids, params_concrete_ingredient_ids = get_ingredient_ids_from_params(params)
    self.base_ingredients.each_with_index do |base_ingredient, idx|
      return false unless base_ingredient.id == params_base_ingredient_ids[idx]
    end
    return true
  end

  def check_substitutions params
    params_base_ingredient_ids, params_concrete_ingredient_ids = get_ingredient_ids_from_params(params)
    flag = true
    self.base_ingredients.each_with_index do |base_ingredient,idx|
      if base_ingredient.id != params_base_ingredient_ids[idx]
        # do not return here! throw a segmentation fault.
        flag = false if !base_ingredient.substitutions.ids.include? params_base_ingredient_ids[idx]
      end
    end
    return flag
  end

  def get_ingredient_ids_from_params params
    base_ingredient_ids = []
    concrete_ingredient_ids = []
    params[:concrete_ingredients].values.each do |concrete_ingredient|
      base_ingredient_ids << concrete_ingredient[:base_ingredient_id].to_i
      concrete_ingredient_ids << concrete_ingredient[:concrete_ingredient_id].to_i
    end
    return base_ingredient_ids, concrete_ingredient_ids
  end

  def get_random_concrete_ingredients params_filters
    if params_filters.nil?
      self.base_ingredients.each_with_object([]) do |base_ingredient, concrete_ingredients|
        substitutions = base_ingredient.substitutions
        substitutions_count = substitutions.count
        num = rand(substitutions_count + 1)
        num == substitutions_count ? \
          concrete_ingredients << base_ingredient.find_random_concrete_ingredient : \
          concrete_ingredients << substitutions[num].find_random_concrete_ingredient
      end
    else
      base_ingredient_ids, handling_store_ids = Array(params_filters[:base_ingredient_ids]&.values&.map(&:to_i)), Array(params_filters[:handling_store_ids]&.values&.map(&:to_i))
      self.base_ingredients.each_with_object([]) do |base_ingredient, concrete_ingredients|
        if base_ingredient_ids.include?(base_ingredient.id)
          concrete_ingredients_candidates = Array(base_ingredient.concrete_ingredients)
        else
          flag = false
          substitution_ids = base_ingredient.substitution_ids
          substitution_ids.each do |id|
            if base_ingredient_ids.include?(id)
              concrete_ingredients_candidates = Array(BaseIngredient.find(id).concrete_ingredients)
              flag = true
            end
          end
          if flag == false
            concrete_ingredients_candidates = Array(base_ingredient.concrete_ingredients).flatten
            concrete_ingredients_candidates.concat base_ingredient.substitutions.map(&:concrete_ingredients).flatten
          end
        end
        concrete_ingredients_candidates.select!{|concrete_ingredient| (handling_store_ids - (concrete_ingredient.handling_store_ids)).empty?}
        concrete_ingredients << concrete_ingredients_candidates.sample
      end
    end
  end

  def get_concrete_ingredients_from_params(params_concrete_ingredients)
    params_concrete_ingredients.values.each_with_object([]) do |concrete_ingredient, concrete_ingredients|
      concrete_ingredients << ConcreteIngredient.includes(:handling_stores).find(concrete_ingredient[:concrete_ingredient_id])
    end
  end

end

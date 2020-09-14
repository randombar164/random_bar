class BaseDrink < ApplicationRecord
  validates :name, uniqueness: { scope: :strength }
  belongs_to :drink_method
  belongs_to :glass_type
  has_many :base_drinks_base_ingredients
  has_many :base_ingredients, through: :base_drinks_base_ingredients

  def self.find_by_params params
    params_base_drink_id_valid?(params) ? \
      BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find(params[:base_drink_id]) : \
      BaseDrink.get_random(params[:filters])
  end

  def self.params_base_drink_id_valid? params
    if params[:base_drink_id].blank? || !Array(1..BaseDrink.last.id).include?(params[:base_drink_id]&.to_i)
      params.delete(:concrete_ingredients)
      params.delete(:base_drink_id)
      return false
    else
      params.delete(:filters)
      return true
    end
  end

  def self.get_random params_filters
    return BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find(rand(1..BaseDrink.count)) if params_filters.nil?

    params_base_ingredient_ids = Array(params_filters[:base_ingredient_ids]&.values&.map(&:to_i))
    params_handling_store_ids = params_filters[:handling_store_ids]&.values&.map(&:to_i) || [1,2,3]

    params_base_ingredient_ids.each do |bi_id|
      return nil unless BaseIngredient.find(bi_id).check_handling_store_ids(params_handling_store_ids)
    end

    cookable_base_drink_ids = params_base_ingredient_ids.present? ? \
                              BaseDrinksBaseIngredient.get_base_drink_ids_from_base_ingredient_ids(params_base_ingredient_ids) : \
                              Array(1..BaseDrink.last.id)
    return nil if cookable_base_drink_ids.empty?

    cookable_base_drink_ids.shuffle!
    cookable_base_drink_ids.each do |bd_id|
      base_drink = BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find(bd_id)
      return base_drink if base_drink.check_handling_store_ids(params_handling_store_ids)
    end
    return nil
  end

  def check_handling_store_ids(handling_store_ids)
    self.base_ingredients.each do |bi|
      return false if (handling_store_ids - bi.handling_store_ids_without_unavailable).length == handling_store_ids.length
    end
    return true
  end

  def concrete_ingredients(params)
    params_concrete_ingredients_valid?(params) ? \
      self.get_concrete_ingredients_from_params(params[:concrete_ingredients]) : \
      self.get_random_concrete_ingredients(params[:filters])
  end

  def params_concrete_ingredients_valid? params
    return false if params[:concrete_ingredients].nil?
    return false unless check_params_base_ingredient_ids_with_concrete_ingredient_ids(params)
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
    self.base_ingredients.each_with_index do |bi, idx|
      return false unless bi.id == params_base_ingredient_ids[idx]
    end
    return true
  end

  def check_substitutions params
    params_base_ingredient_ids, params_concrete_ingredient_ids = get_ingredient_ids_from_params(params)
    flag = true
    self.base_ingredients.each_with_index do |bi,idx|
      if bi.id != params_base_ingredient_ids[idx]
        # do not return here! throw a segmentation fault.
        flag = false if !bi.substitutions.ids.include? params_base_ingredient_ids[idx]
      end
    end
    return flag
  end

  def get_ingredient_ids_from_params(params)
    base_ingredient_ids = []
    concrete_ingredient_ids = []
    params[:concrete_ingredients].values.each do |concrete_ingredient|
      base_ingredient_ids << concrete_ingredient[:base_ingredient_id].to_i
      concrete_ingredient_ids << concrete_ingredient[:concrete_ingredient_id].to_i
    end
    return base_ingredient_ids, concrete_ingredient_ids
  end

  def get_random_concrete_ingredients(params_filters)
    if params_filters.nil?
      concrete_ingredients = self.base_drinks_base_ingredients.each_with_object([]) do |bd_bi, concrete_ingredients|
        base_ingredient = bd_bi.base_ingredient
        substitutions = base_ingredient.substitutions
        substitutions_count = substitutions.count
        num = rand(substitutions_count + 1)
        num == substitutions_count ? \
          concrete_ingredients << bi.find_random_concrete_ingredient : \
          concrete_ingredients << substitutions[num].find_random_concrete_ingredient
      end and return concrete_ingredients
    end

    concrete_ingredients = self.base_drinks_base_ingredients.each_with_object([]) do |bd_bi, concrete_ingredients|
      base_ingredient = bd_bi.base_ingredient
      if params_filters[:base_ingredient_ids].include?(base_ingredient.id)
        concrete_ingredients_candidates = Array(base_ingredient.concrete_ingredients)
      else
        flag = false
        substitution_ids = base_ingredient.substitution_ids
        substitution_ids.each do |id|
          if filter_base_ingredient_ids.include?(id)
            concrete_ingredients_candidates = Array(BaseIngredient.find(id).concrete_ingredients)
            flag = true
          end
        end
        if flag != true
          concrete_ingredients_candidates = Array(base_ingredient.concrete_ingredients).flatten
          concrete_ingredients_candidates.concat(base_ingredient.substitutions.map(&:concrete_ingredients).flatten)
        end
      end
      concrete_ingredients_candidates.select!{|concrete_ingredient| (filter_handling_store_ids - (concrete_ingredient.handling_store_ids)).empty?}
      concrete_ingredients << concrete_ingredients_candidates.sample
    end
    return concrete_ingredients
  end

  def get_concrete_ingredients_from_params(params_concrete_ingredients)
    params_concrete_ingredients.values.each_with_object([]) do |concrete_ingredient, concrete_ingredients|
      concrete_ingredients << ConcreteIngredient.includes(:handling_stores).find(concrete_ingredient[:concrete_ingredient_id])
    end
  end

end

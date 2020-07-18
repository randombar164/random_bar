class BaseDrink < ApplicationRecord
  belongs_to :drink_method
  belongs_to :glass_type
  has_many :base_drinks_base_ingredients
  has_many :base_ingredients, through: :base_drinks_base_ingredients

  # AND searching
  def self.find_by_filters params_filters
    # params から base_ingredient_ids を含む base_drink を取り出す
    if params_filters[:base_ingredient_ids].blank?
      base_drink_ids = [*1..BaseDrink.last.id]
    else
      params_base_ingredient_ids = params_filters[:base_ingredient_ids].values.map(&:to_i)
      base_drink_ids_candidate = BaseDrinksBaseIngredient.where(base_ingredient_id: params_base_ingredient_ids).group(:base_drink_id).having('count(base_drink_id)>=?',params_base_ingredient_ids.length).count.keys
      base_drink_ids = base_drink_ids_candidate.select do |base_drink_id|
        base_ingredient_ids = BaseDrink.find(base_drink_id).base_ingredients.ids
        (base_ingredient_ids - params_base_ingredient_ids).length == base_ingredient_ids.uniq.length - params_base_ingredient_ids.length
      end
    end
    return nil if base_drink_ids.empty?
    if params_filters[:handling_store_ids].blank?
      return BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find(base_drink_ids.sample)
    else
      handling_store_ids = params_filters[:handling_store_ids].values.map(&:to_i)
      concrete_ingredient_ids = ConcreteIngredientsHandlingStore.where(handling_store_id: handling_store_ids).group(:concrete_ingredient_id).having('count(concrete_ingredient_id)=?',handling_store_ids.length).count.keys
      # substitution も含めないと
      base_ingredient_ids = concrete_ingredient_ids.each_with_object([]) { |concrete_ingredient_id, base_ingredient_ids| base_ingredient_ids << ConcreteIngredient.find(concrete_ingredient_id).base_ingredient.id }
      base_drinks = base_drinks_from_base_ingredients(base_drink_ids.uniq, base_ingredient_ids.uniq)
    end
    return base_drinks.sample
  end

  def get_random_concrete_ingredients handling_store_ids=[]
    if handling_store_ids.empty?
      self.base_ingredients.each_with_object([]) do |base_ingredient, concrete_ingredients|
        substitutions = base_ingredient.substitutions
        substitutions_count = substitutions.count
        num = rand(substitutions_count + 1)
        num == substitutions_count ? \
          concrete_ingredients << base_ingredient.find_random_concrete_ingredient : \
          concrete_ingredients << substitutions[num].find_random_concrete_ingredient
      end
    else
      self.base_ingredients.each_with_object([]) do |base_ingredient, concrete_ingredients|
        concrete_ingredients_candidates = Array(base_ingredient.concrete_ingredients).flatten
        concrete_ingredients_candidates.concat base_ingredient.substitutions.map(&:concrete_ingredients).flatten
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

  def self.base_drinks_from_base_ingredients(base_drink_ids, base_ingredient_ids)
    BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find(base_drink_ids).each_with_object([]) do |base_drink, base_drinks|
      base_drinks << base_drink if base_drink.check_enough_base_ingredients?(base_ingredient_ids)
    end
  end

  def check_enough_base_ingredients?(ids)
    self.base_drinks_base_ingredients.each do |base_drinks_base_ingredient|
      return false unless ids.include?(base_drinks_base_ingredient.base_ingredient_id)
    end
    return true
  end

end

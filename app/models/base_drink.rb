class BaseDrink < ApplicationRecord
  validates :name, uniqueness: { scope: :strength }

  belongs_to :drink_method
  belongs_to :glass_type
  has_many :base_drinks_base_ingredients
  has_many :base_ingredients, through: :base_drinks_base_ingredients

  scope :with_recipe, -> { includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, { unit: [:unit_conversion] } ] } ) }
  scope :random,      -> { where( 'id >= ?', rand(BaseDrink.first.id..BaseDrink.last.id) ).first }

  def self.get_random params_filters
    return BaseDrink.with_recipe.random if params_filters.nil?

    # params_filters[:base_ingredient_ids].each do |bi_id|
    #   base_ingredient = BaseIngredient.find(bi_id)
    #   return nil unless base_ingredient.has_handling_store_ids(params_filters[:handling_store_ids])
    # end

    cookable_base_drink_ids = params_filters[:base_ingredient_ids].present? ? \
                              BaseDrinksBaseIngredient.get_base_drink_ids_from_base_ingredient_ids(params_filters[:base_ingredient_ids]) : \
                              Array(1..BaseDrink.last.id)
    return nil if cookable_base_drink_ids.empty?

    cookable_base_drink_ids.shuffle!
    cookable_base_drink_ids.each do |bd_id|
      base_drink = BaseDrink.with_recipe.find(bd_id)
      return base_drink if base_drink.check_handling_store_ids(params_filters[:handling_store_ids])
    end
    return nil
  end

  def check_handling_store_ids(handling_store_ids)
    self.base_ingredients.each do |bi|
      return false if (handling_store_ids - bi.handling_store_ids_without_unavailable).length == handling_store_ids.length
    end
    return true
  end

  def get_random_concrete_ingredients(params_filters)
    if params_filters.nil?
      concrete_ingredients = self.base_drinks_base_ingredients.each_with_object([]) do |bd_bi, concrete_ingredients|
        base_ingredient = bd_bi.base_ingredient
        substitutions = base_ingredient.substitutions
        substitutions_count = substitutions.count
        num = rand(substitutions_count + 1)
        num == substitutions_count ? \
          concrete_ingredients << base_ingredient.find_random_concrete_ingredient : \
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
          if params_filters[:base_ingredient_ids].include?(id)
            concrete_ingredients_candidates = Array(BaseIngredient.find(id).concrete_ingredients)
            flag = true
          end
        end
        if flag != true
          concrete_ingredients_candidates = Array(base_ingredient.concrete_ingredients).flatten
          concrete_ingredients_candidates.concat(base_ingredient.substitutions.map(&:concrete_ingredients).flatten)
        end
      end
      concrete_ingredients_candidates.select!{|concrete_ingredient| (params_filters[:handling_store_ids] - (concrete_ingredient.handling_store_ids)).empty?}
      concrete_ingredients << concrete_ingredients_candidates.sample
    end
    return concrete_ingredients
  end

  def get_concrete_ingredients_from_params(params_concrete_ingredients)
    params_concrete_ingredients.values.each_with_object([]) do |concrete_ingredient, concrete_ingredients|
      concrete_ingredients << ConcreteIngredient.includes(:handling_stores).find(concrete_ingredient[:concrete_ingredient_id])
    end
  end

  # base_drinks カウント用
  def self.base_drinks_from_base_ingredients(ids)
    base_drinks = []
    BaseDrink.all.includes(:base_drinks_base_ingredients).each do |base_drink|
      base_drinks.push(base_drink) if base_drink.check_enough_ingredients?(ids)
    end
    return base_drinks
  end

  def check_enough_ingredients?(ids)
    self.base_drinks_base_ingredients.each do |base_drinks_base_ingredient|
      return false unless ids.include?(base_drinks_base_ingredient.base_ingredient_id)
    end
    return true
  end

end
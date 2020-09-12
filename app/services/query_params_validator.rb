class QueryParamsValidator
    def initialize(query_params)
        @query_params = query_params
    end

    def validate
        delete_drink_specification and return @query_params if !is_base_drink_id_valid?
        delete_drink_specification and return @query_params if !is_concrete_ingredients_valid?
        
        return @query_params
    end

    private

    def is_base_drink_id_valid?
        BaseDrink.find_by(id: @query_params[:base_drink_id]).present?
    end

    def is_concrete_ingredients_valid?
        return true if !@query_params[:concrete_ingredients].present?

        # concrete_ingredients中のbase_ingredient_idとconcrete_ingredient_idが正しいかチェック
        concrete_ingredients = parse_concrete_ingredients()
        return false if concrete_ingredients.nil?

        # base_drink_idとconcrete_ingredientsが一致するかチェック
        base_drink_from_params = BaseDrink.find(@query_params[:base_drink_id])
        return false if base_drink_from_params.base_ingredients.length != concrete_ingredients.length
        is_break = false
        base_drink_from_params.base_ingredients.each_with_index do |base_ingredient, idx|
            bi_ids_include_substitutions = [base_ingredient.id].concat(base_ingredient.substitutions.ids)
            is_break = true and break unless bi_ids_include_substitutions.include?(concrete_ingredients[idx].base_ingredient_id)
        end

        is_break ? false : true
    end

    def parse_concrete_ingredients
        @query_params[:concrete_ingredients].each_with_object([]) do | p_conc_ing, concrete_ingredients |
            concrete_ingredient = ConcreteIngredient.find_by(id: p_conc_ing[:concrete_ingredient_id])
            return nil if concrete_ingredient.nil?
            return nil if concrete_ingredient.base_ingredient_id != p_conc_ing[:base_ingredient_id]
            concrete_ingredients << concrete_ingredient
        end
    end

    def delete_drink_specification
        @query_params.delete(:base_drink_id)
        @query_params.delete(:concrete_ingredients)
    end
end
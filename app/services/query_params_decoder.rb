class QueryParamsDecoder
    def initialize(query_params)
        @query_params = query_params
    end

    def decode
        if @query_params[:filters].present?
            @query_params[:filters][:base_ingredient_ids] = Array(@query_params[:filters][:base_ingredient_ids]&.values&.map(&:to_i))
            @query_params[:filters][:handling_store_ids]  = @query_params[:filters][:handling_store_ids ]&.values&.map(&:to_i) || [1,2,3]
            @query_params[:filters][:and] ||= false
        end
        return @query_params
    end
end
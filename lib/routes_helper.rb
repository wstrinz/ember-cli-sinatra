module RoutesHelper
  def api_routes(model)
    app = Sinatra::Application
    plural_sym = model.model_name.collection.to_sym
    single_sym = model.model_name.element.to_sym

    plural_associations = model.reflect_on_all_associations.reject do |a|
      a.macro == :belongs_to
    end
    association_colums = plural_associations.map do |a|
      "#{a.name.to_s.singularize}_ids".to_sym
    end

    json_opts = {methods: association_colums}

    app.get("/#{plural_sym.to_s}") do
      content_type :json
      if params[:ids]
        { plural_sym => model.where(id: params[:ids]) }.to_json(json_opts)
      else
        { plural_sym => model.all }.to_json(json_opts)
      end
    end

    app.get("/#{plural_sym}/:id") do
      content_type :json
      { single_sym => model.find(params[:id]) }.to_json(json_opts)
    end
  end
end
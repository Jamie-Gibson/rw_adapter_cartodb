class DatasetParams < Hash
  def initialize(params)
    sanitized_params = {
      id: params[:id] || nil,
      connector_name: params[:connector_name] || nil,
      provider: params[:provider] || nil,
      format: params[:format] || nil,
      data_attributes: params[:data_attributes] || [],
      connector_url: params[:connector_url] || nil,
      connector_path: params[:connector_path] || nil,
      table_name: params[:table_name] || nil
    }

    super(sanitized_params)
    merge!(sanitized_params)
  end

  def self.sanitize(params)
    new(params)
  end
end

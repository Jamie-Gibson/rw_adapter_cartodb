Rails.application.routes.draw do
  scope module: :v1, constraints: APIVersion.new(version: 1, current: true) do
    with_options only: :show, path: 'query' do |show_only|
      show_only.resources :connectors
    end
  end
end

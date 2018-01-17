require_dependency 'zapier_rest_hooks/application_controller'

module ZapierRestHooks
  class HooksController < ApplicationController
    def create
      hook = Hook.new(hook_params)
      render nothing: true, status: 500 && return unless hook.save
      Rails.logger.info "Created REST hook: #{hook.inspect}"
      # The Zapier documentation says to return 201 - Created.
      render json: hook.to_json(only: :id), status: 201
    end

    def destroy
      hook = Hook.find(params[:id]) if params[:id]
      if hook.nil? && params[:subscription_url]
        hook = Hook.find_by_subscription_url(params[:subscription_url]).destroy
      end
      Rails.logger.info "Destroying REST hook: #{hook.inspect}"
      hook.destroy
      head :ok
    end

    private

    def hook_params
      params[:event_name] ||= params[:name]
      params[:hook] = params
      params.require(:hook).permit(:event_name, :target_url, :owner_id, :owner_class_name, :subscription_url)
    end
  end
end

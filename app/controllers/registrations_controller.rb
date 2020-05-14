class RegistrationsController < ApplicationController

  def new
    step_name = params[:step_name]
    @registration = StepFactory.create(step_name)
  end

  def create
    step_name = params[:step_name]
    @registration = StepFactory.create(step_name)
    @registration.assign_attributes(registration_params)

    if @registration.valid?
      update_session_registration_hash
      redirect_to new_registration_path(step_name: @registration.next_step)
    else
     render :new
     # redirect_to new_registration_path(step_name: step_name)
    end
  end

  private

  def update_session_registration_hash
    session[:registration] ||= {}
    session[:registration].merge!(registration_params)
  end

  def entity_name
    @registration.model_name.name.underscore.to_sym
  end

  def registration_params
    if params[entity_name]
      params.require(entity_name).permit(params[entity_name].keys.map(&:to_sym))
    else
      {}
    end
  end

end 
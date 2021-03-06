class API::PlansController < ApplicationController
  def create
    plan = Plan.new(plan_params)
    if plan.save!
      createPlan(plan)
      render json: plan, status: :created
    else
      render json: {errors: plan.errors}, status: :unprocessable_entity
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:currency, :interval, :name, :amount, :interval_count, :statement_descriptor)
  end

  def createPlan(plan)
    Stripe::Plan.create(
      amount: plan.amount,
      interval: plan.interval,
      name: plan.name,
      currency: plan.currency,
      interval_count: plan.interval_count,
      statement_descriptor: plan.statement_descriptor
    )
  end
end

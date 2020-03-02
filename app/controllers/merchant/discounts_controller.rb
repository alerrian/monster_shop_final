class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = current_user.merchant.discounts
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
  end

  def create
    merchant = current_user.merchant
    discount = merchant.discounts.create(discount_params)

    if discount.save
      redirect_to merchant_discounts_path
    else
      generate_flash(discount)
      render :new
    end
  end

  private

  def discount_params
    params.permit(
      :name,
      :item_threshold,
      :percentage_off
    )
  end
end

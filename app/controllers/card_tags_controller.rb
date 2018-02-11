class CardTagsController < ApplicationController
  helper_method :card

  def index
    @tags = card.tags.of_type(params[:type])
  end

  def create
    card.add_tag(
      Tag.find_by(
        type: tag_params[:type],
        canonical_name: params[:name]
      )
    )
    redirect_to list_card_tags_path
  end

  def destroy
    card.remove_tag(
      Tag.find_by(
        type: tag_params[:type],
        canonical_name: params[:name]
      )
    )
    redirect_to list_card_tags_path
  end

protected

  def tag_params
    params.require(:tag).permit(:canonical_name, :type, :variant)
  end

  def card
    @card ||= Card.find_by_id(params[:card_id])
  end
end
class SavePost < ApplicationRecord
  include PublicActivity::Model
  tracked owner: -> (controller, model){controller && controller.current_user}	
  belongs_to :post
  belongs_to :user
end

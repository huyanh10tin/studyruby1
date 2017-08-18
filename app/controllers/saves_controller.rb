class SavesController < ApplicationController
  before_action :logged_in_user, only: [:save, :unsave]
end
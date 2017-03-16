class PagesController < ApplicationController
before_action :set_current_user, only: [:home]
  def home
    @posts = Post.all
  end

private
  def set_current_user
    @user = current_user

  end
end

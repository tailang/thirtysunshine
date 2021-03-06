class ApplicationController < ActionController::Base
  protect_from_forgery

  #设置登录后和退出后，跳转页面
  after_filter :store_location

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
  def after_sign_up_path_for(resource)
    edit_user_path(current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_path
  end

  def set_seo_meta(meta_keywords='', meta_description='')
    @meta_keywords = meta_keywords
    @meta_description = meta_description
  end
end

# coding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery

  # ログイン認証
  before_filter :authorize

  # セッション有効期限延長
  before_filter :reset_session_expires

  private

  #---------------#
  # show_markdown #
  #---------------#
  # Markdown変換
  def show_markdown( text )
    html_render = HtmlWithPygments.new( hard_wrap: true, filter_html: true )
    markdown    = Redcarpet::Markdown.new( html_render, autolink: true, fenced_code_blocks: true, space_after_headers: true )

    return markdown.render( text )
  end

  helper_method :show_markdown

  #-----------#
  # authorize #
  #-----------#
  # ログイン認証
  def authorize
    # セッション／トップコントローラ以外で
    if params[:controller] != "sessions" and params[:controller] != "top"
      # 未ログインであればルートヘリダイレクト
      if session[:user_id].blank?
        # リクエストURL保管
        session[:request_url] = request.url

        redirect_to :root and return
      end
    end
  end

  #-----------------------#
  # reset_session_expires #
  #-----------------------#
  # セッション期限延長
  def reset_session_expires
    request.session_options[:expire_after] = 2.weeks
  end

  #--------------#
  # current_user #
  #--------------#
  def current_user
    @current_user ||= User.where( id: session[:user_id] ).first
  end

  helper_method :current_user

end

#encoding: utf-8
module ApplicationHelper
  def full_title(page_title)
    base_title = "30度阳光"
	if page_title.empty?
	  base_title
	else
	  "#{base_title} | #{page_title}"
	end
  end
  
#markdown支持  
  #  def markdown(text)
  #   options = {   
  #     :autolink => true, 
  #     :fenced_code_blocks => true,
  #     :no_intra_emphasis => true,
  #     :hard_wrap => true,
  #     :strikethrough =>true
  #   }
  #   markdown = Redcarpet::Markdown.new(HTMLwithCodeRay,options)
  #   nl_to_br(markdown.render(text)).html_safe
  # end

  # class HTMLwithCodeRay < Redcarpet::Render::HTML
  #   def block_code(code, language)
  #     CodeRay.scan(code, language).div(:tab_width=>2)
  #   end
  # end

  # def nl_to_br(text)
  #   text.gsub("\r\n", "<br/>").gsub("\r", "<br/>").gsub("\n", "<br/>")
  # end

  def count_unread_notification
    if current_user
      @unread_count = current_user.notifications.where(unread: true).count
    else
      @unread_count = 0
    end
  end
  
  def make_mention_links(text)
    mention_regexp = /@([a-zA-Z0-9_\-\p{han}]+)/u
    text = text.gsub(mention_regexp) do
      if $1.present?
        user = User.find_by_username($1)
        if user.present?
          "<a href='/users/#{user.id}'>@#{$1}</a>"
        else
          "@#{$1}"
        end
      else
        "@#{$1}"
      end
  end
end

  def output_content(text)
    return "" if text.nil? or text.blank?
    make_mention_links(text).html_safe
  end

end


module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :notice then "bg-green-500"
    when :alert  then "bg-red-500"
    when :error  then "bg-yellow-500"
    else "bg-gray-500"
    end
  end

  def page_title(title= '')
    base_title = '旅つなぎ'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def meta_description(discription = '最高の旅スポットを探す！夢の旅リレー！"旅つなぎ"は自分のおすすめ旅行スポットを簡単に共有し合えるサービスです。
                                     一人旅、食べ歩き、温泉旅行、国内旅行、聖地巡礼など旅行の思い出を共有しましょう！')
    content_for?(:meta_description) ? content_for(:meta_description) : discription
  end

  def address_processing(address)
    address = sanitize(address)
    address.gsub(/日本、/, '')
  end

  def auto_link_urls(text)
    sanitized_text = sanitize(text)
    sanitized_text.gsub(%r{(https?://[^\s<]+)}) do |url|
      "<a href='#{url}' class='text-accent-blue hover:opacity-50' target='_blank' rel='noopener noreferrer'>#{url}</a>"
    end.html_safe
  end
  # def change_url(url)
  #   sanitized_url = sanitize(url)
  #   sanitized_url.gsub('http://', 'https://')
  # end
end

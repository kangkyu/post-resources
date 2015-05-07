module ApplicationHelper

  def external_url(url)
    link_to "http://#{url}", target: "_blank" do
      yield
    end
  end

end

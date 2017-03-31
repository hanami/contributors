module Web::Views::Static
  class Faq
    include Web::View

    def title
      'F.A.Q. page'
    end

    def faq_page_class
      'active'
    end
  end
end

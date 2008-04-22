module RailsSeleniumStory::Matchers
  class HaveTag
    include RailsSeleniumStory::Helpers::EscapeString
    extend RailsSeleniumStory::Helpers::EscapeString
    
    attr_reader :content, :tag
  
    def initialize(tag, content=nil, &block)
      @@scopes ||= []
      @tag = tag
      @content = content
      @block = block
      @@scopes << self
    end
  
    def matches?(browser, &block)
      @block.call if @block
      block.call if block
      if @@scopes.size == 1
        if @content
          js = "$$('#{@tag}').#{self.class.build_selector_call(self)}.any();"
        else
          js = "$$('#{@tag}').any()"
        end
      else
        js = []
        while scope=@@scopes.shift
          if js.empty?
            js << "$$('#{scope.tag}').#{self.class.build_selector_call(scope)}"
          else
            js << ".select(function(el){ return el.down('#{scope.tag}')}).#{self.class.build_selector_call(scope)}"
          end
        end
        js << ".any();"
        js = js.join("")
      end
      @@scopes.clear
      result = browser.get_eval(js)
      result == "false" ? false : true
    end
    
    def self.build_selector_call(scope)
      "select(function(el){ return (/#{create_content_regex(scope.content)}/i).test(el.innerHTML); })"
    end
    
    def self.create_content_regex(content)
      escape_regex(content)
    end
  end
  
  def have_tag(tag, content=nil, &blk)
    HaveTag.new(tag, content, &blk)
  end
  
  def with_tag(tag, content)
    have_tag(tag, content)
  end
end



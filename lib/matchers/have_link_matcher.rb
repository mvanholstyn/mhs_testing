module Spec::Matchers 
  # Notes:
  #  - using onclick adds a [onclick*=?] rather than a [onclick=?]
  class HaveLink  
    constructor :href, :method, :selector, :scope, :onclick, :strict => false do
      @href = @href.gsub('&', '&amp;')
    end
  
    def matches?(target)
      assert_select(build_onclick_expression)
      @error.nil?
    end
    
    def build_onclick_expression
      case @method.to_s
        when "get", "post"
          /[._]method.*#{@method.to_s.upcase}/
        when "delete", "put"
          /_method.*#{@method}/          
      end 
    end
    
    def build_selector
      selector_arr = []
      selector_arr << ["a#{@selector}[href=?]", @href]
      selector_arr << ["[onclick*=?]", @onclick] if @onclick
      selector_arr.inject([""]) do |result, arr|
        result[0] << arr.first
        result.push(*arr[1..-1])
      end
    end
    
    def assert_select(onclick_expression)
      begin
        if onclick_expression
          @scope.send(:assert_select,"a#{@selector}[href=?][onclick*=?]", @href, onclick_expression)
        else
          @scope.send(:assert_select, *build_selector)
        end
      rescue ::Test::Unit::AssertionFailedError => @error
      end
    end
  
    def failure_message
      @error.message
    end
    alias_method :negative_failure_message, :failure_message
  end  
  
  # Actual matcher that is exposed.  
  def have_link(options)
    HaveLink.new(options.merge(:scope => self))
  end  
end  
module Spec::Matchers 
  class HaveLinkToFunction < Spec::Matchers::HaveLink
    # Currently there is a bug in constructor which fails to inherit the constructor block successful.
    # This essentially inherits the constructor of the HaveLink matcher.
    constructor :strict => false do ; end
    
    def matches?(target)
      assert_select(build_onclick_expression)
      @error.nil?
    end
  end
  
  # Actual matcher that is exposed.  
  def have_link_to_function(function, options={})
    options[:href] = '#' unless options[:href]
    HaveLinkToFunction.new(options.merge(:scope => self, :onclick => function)) 
  end  
end  
require File.expand_path(File.dirname(__FILE__)) + '/../../spec_helper'

describe RailsSeleniumStory do
  include RailsSeleniumStory::Matchers
  
  before do
    @browser = mock("browser")
  end
  
  it "generates the javascript to find at least one element matching a given CSS selector" do
    @browser.should_receive(:get_eval).with("$$('li').any()")
    have_tag = RailsSeleniumStory::Matchers::HaveTag.new("li")
    have_tag.matches?(@browser)
    
    @browser.should_receive(:get_eval).with("$$('#li').any()")
    have_tag = RailsSeleniumStory::Matchers::HaveTag.new("#li")
    have_tag.matches?(@browser)
  end
  
  it "generates the javascript to find at least one element whose content matches the given string" do
    @browser.should_receive(:get_eval).with(
      %|$$('li').select(function(el){ return (/argh!/i).test(el.innerHTML); }).any();|
    )
    have_tag = RailsSeleniumStory::Matchers::HaveTag.new("li", "argh!")
    have_tag.matches?(@browser)
  end
    
  describe "the generated javascript to find at least one element whose content matches the given string" do
    it "escapes quotes" do
      @browser.should_receive(:get_eval).with(
        %|$$('li').select(function(el){ return (/who\'s the boss of \"me\"/i).test(el.innerHTML); }).any();|
      )
      have_tag = RailsSeleniumStory::Matchers::HaveTag.new("li", "who's the boss of \"me\"")
      have_tag.matches?(@browser)
    end
  
    it "escapes parens" do
      @browser.should_receive(:get_eval).with(
        %|$$('li').select(function(el){ return (/will you go out with me \(circle yes or no\)/i).test(el.innerHTML); }).any();|
      )
      have_tag = RailsSeleniumStory::Matchers::HaveTag.new("li", "will you go out with me (circle yes or no)")
      have_tag.matches?(@browser)      
    end
    
    it "escapes square brackets" do
      @browser.should_receive(:get_eval).with(
        %|$$('li').select(function(el){ return (/will you go out with me \[circle yes or no\]/i).test(el.innerHTML); }).any();|
      )
      have_tag = RailsSeleniumStory::Matchers::HaveTag.new("li", "will you go out with me [circle yes or no]")
      have_tag.matches?(@browser)      
    end
    
    it "escapes curly brackets" do
      @browser.should_receive(:get_eval).with(
        %|$$('li').select(function(el){ return (/will you go out with me \{circle yes or no\}/i).test(el.innerHTML); }).any();|
      )
      have_tag = RailsSeleniumStory::Matchers::HaveTag.new("li", "will you go out with me {circle yes or no}")
      have_tag.matches?(@browser)            
    end
    
    it "escapes the plus sign, backslash and question mark" do
      @browser.should_receive(:get_eval).with(
        %|$$('li').select(function(el){ return (/does 1\+1=2\? \\ yes/i).test(el.innerHTML); }).any();|
      )
      have_tag = RailsSeleniumStory::Matchers::HaveTag.new("li", 'does 1+1=2? \ yes')
      have_tag.matches?(@browser)
    end
  end

  it "generates the javascript to find at least one element whose content matches the given string using blocks" do
    @browser.should_receive(:get_eval).with(
      %|$$('ul').select(function(el){ return (/argh!/i).test(el.innerHTML); }).select(function(el){ return el.down('li')}).select(function(el){ return (/.*/i).test(el.innerHTML); }).any();|
    )
    matcher = have_tag("ul", "argh!") do
      have_tag("li")
    end
    matcher.matches?(@browser) 
  end
  
  describe "the generated javascript to find at least one element whose content matches the given string using blocks" do
    it "works with scoped have_tags which specify their own content" do
      @browser.should_receive(:get_eval).with(
        %|$$('ul').select(function(el){ return (/.*/i).test(el.innerHTML); }).select(function(el){ return el.down('li')}).select(function(el){ return (/donkey kong/i).test(el.innerHTML); }).any();|
      )
      matcher = have_tag("ul") do
        have_tag("li", "donkey kong")
      end
      matcher.matches?(@browser) 
    end
  end

end


module ValidationMatchers
  # class ValidatesPresenceOf
  #   attr_reader :attribute, :valid_value, :model, :error_name
  # 
  #   def initialize(attribute, valid_value, error_name = nil)
  #     @attribute = attribute
  #     @valid_value = valid_value
  #     @error_name = error_name || attribute
  #   end
  # 
  #   def matches?(model)
  #     @model = model
  #     valid = true
  #     model.send("#{attribute}=",  nil)
  #     valid &= !model.valid?
  #     valid &= model.errors.on(error_name)
  #     model.send("#{attribute}=", valid_value)
  #     valid &= model.valid?
  #   end
  # 
  #   def failure_message
  #     "expected #{model.inspect} to validate presence of #{attribute}"
  #   end
  # 
  #   def negative_failure_message
  #     "expected #{model.inspect} not to validate presence of #{attribute}"
  #   end
  # end
  # 
  # def validate_presence_of(attribute, valid_value, error_name = nil)
  #   ValidatesPresenceOf.new(attribute, valid_value, error_name)
  # end
  # 
  # class ValidatesInclusionOf
  #   attr_reader :attribute, :valid_values, :model, :error_name
  #   
  #   def initialize(attribute, valid_values, error_name = nil)
  #     @attribute = attribute
  #     @valid_values = valid_values
  #     @error_name = error_name || attribute
  #   end
  # 
  #   def matches?(model)
  #     @model = model
  #     valid = true
  #     model.send("#{attribute}=",  nil)
  #     valid &= !model.valid?
  #     valid &= model.errors.on(error_name)
  #     valid_values.each do |valid_value|
  #       model.send("#{attribute}=", valid_value)
  #       valid &= model.valid?
  #     end
  #     return valid
  #   end
  # 
  #   def failure_message
  #     "expected #{model.inspect} to validate inclusion of #{attribute} in #{valid_values.inspect}"
  #   end
  # 
  #   def negative_failure_message
  #     "expected #{model.inspect} not to validate inclusion of #{attribute} in #{valid_values.inspect}"
  #   end
  # end
  # 
  # def validate_inclusion_of(attribute, valid_values, error_name = nil)
  #   ValidatesInclusionOf.new(attribute, valid_values, error_name)
  # end

  class ValidatesAttribute
    attr_reader :attribute, :valid_values, :invalid_values, :model
    
    def initialize(attribute, valid_values, invalid_values = [])
      @attribute = attribute
      @valid_values = valid_values
      @invalid_values = invalid_values
      @valid_errors = []
      @invalid_errors = []
    end
  
    def matches?(model)
      @model = model

      valid_values.each do |valid_value|
        model.send("#{attribute}=", valid_value)
        @valid_errors << valid_value unless model.valid?
      end

      invalid_values.each do |invalid_value|
        model.send("#{attribute}=", invalid_value)
        @invalid_errors << invalid_value if model.valid?
      end

      @valid_errors.empty? && @invalid_errors.empty?
    end
  
    def failure_message
      message = "expected #{model.class.name} to "
      message << "pass validation checks when #{attribute} is set to #{@valid_errors.map(&:inspect).join(',')}" unless @valid_errors.empty?
      message << " and " if !@valid_errors.empty? && !@invalid_errors.empty?
      message << "fail validation checks when #{attribute} is set to #{@invalid_errors.map(&:inspect).join(',')}" unless @invalid_errors.empty?
        
      message
    end
  end
  
  def validate(attribute, valid_values, invalid_values = [])
    ValidatesAttribute.new(attribute, valid_values, invalid_values)
  end
end
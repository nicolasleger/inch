module Inch
  module Evaluation
    def self.for(code_object)
      class_for(code_object).new(code_object)
    end

    private
    def self.class_for(code_object)
      class_name = code_object.class.to_s.split('::').last
      eval(class_name)
    rescue
      Base
    end
  end
end

require_relative 'evaluation/base'
require_relative 'evaluation/namespace_object'
require_relative 'evaluation/class_object'
require_relative 'evaluation/constant_object'
require_relative 'evaluation/method_object'
require_relative 'evaluation/module_object'

require_relative 'evaluation/role/base'
require_relative 'evaluation/role/bad_role'
require_relative 'evaluation/role/method'
require_relative 'evaluation/role/method_parameter'
require_relative 'evaluation/role/namespace'
require_relative 'evaluation/role/object'
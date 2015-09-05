require "date_supercharger/version"
require "active_record"

module DateSupercharger
  extend ActiveSupport::Concern

  included do
    def self.method_missing(method_sym, *arguments, &block)
      return super unless descends_from_active_record?
      match = ModelDateExtensionMatch.new(self,method_sym)

      if match.match?
        new_method = "#{match.attribute}_#{match.suffix}"
        case match.suffix
        when :after,:before,:before_or_at,:after_or_at
          operators = { after: ">", before: "<", before_or_at: "<=", after_or_at: ">=" }
          singleton_class.class_eval do
            define_method(new_method) do |date|
              where("#{match.attribute} #{operators[match.suffix]} ?", date)
            end
          end
        when :between,:between_inclusive
          methods = {between: ["after_or_at","before"],between_inclusive:["after_or_at","before_or_at"]}
          singleton_class.class_eval do
            define_method(new_method) do |from,to|
              from_method = methods[match.suffix].first
              to_method = methods[match.suffix].second
              send("#{match.attribute}_#{from_method}",from).send("#{match.attribute}_#{to_method}",to)
            end
          end
        end
        send(method_sym, *arguments)
      else
        super
      end
    end

    def self.respond_to?(method_sym, include_private = false)
      return super unless descends_from_active_record?
      if ModelDateExtensionMatch.new(self,method_sym).match?
        true
      else
        super
      end
    end
  end

  class ModelDateExtensionMatch

    attr_accessor :attribute,:suffix

    def initialize(model,method_sym)
      #TODO: implement between and between_inclusive
      if method_sym.to_s =~ /^(.+)_(before|after|before_or_at|after_or_at|between|between_inclusive)$/
        date_columns = model.columns_hash.keys.select { |c| [:datetime,:date].include? model.columns_hash[c].type }.map(&:to_sym)
        if date_columns.include? $1.to_sym
          @attribute = $1.to_sym
          @suffix = $2.to_sym
        end
      end

    end

    def match?
      @attribute != nil
    end
  end

end
ActiveRecord::Base.send :include, DateSupercharger

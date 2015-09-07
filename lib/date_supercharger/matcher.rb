module DateSupercharger
  class Matcher

    attr_accessor :attribute,:suffix

    def initialize(model,method_sym)
      if method_sym.to_s =~ /^(.+)_(before|after|before_or_at|after_or_at|between|between_inclusive)$/
        date_columns = get_date_columns(model)

        if date_columns.include? $1.to_sym
          @attribute = $1.to_sym
          @suffix = $2.to_sym
        end
      end

    end

    def match?
      @attribute != nil
    end

    private

      def get_date_columns(model)
        model.columns_hash.keys.select do |c|
          [:datetime,:date].include? model.columns_hash[c].type
        end.map(&:to_sym)
      end
  end
end

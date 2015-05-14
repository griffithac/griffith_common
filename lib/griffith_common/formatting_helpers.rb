module GriffithCommon
  module FormattingHelpers
    def simple_number(val)
      return '-' if val.nil? || val.to_f.zero?
      val == val.to_i ? val.to_i : val.round(4)
    end

    def percentage(val, precision = 2)
      return '-' if val.nil? || val.to_f.zero?
      number_to_percentage(val * 100, precision: precision)
    end
    alias_method :decimal_to_percentage, :percentage

    def currency(val, unit: "", separator: ".", delimiter: ",", precision: 2)
      return '-' if val.nil? || val.to_f.zero?
      number_to_currency(val, unit: unit,
                              separator: separator,
                              delimiter: delimiter,
                              precision: precision)
    end

    def quantity(val)
      return '-' if val.nil? || val.zero?
      number_with_precision(val.to_f, precision: 2, delimiter: ',')
    end
  end
end

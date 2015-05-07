module GriffithCommon
  module FormattingHelpers
    def simple_number(number)
      if number.nil? || number.zero?
        '-'
      else
        number == number.to_i ? number.to_i : number.round(4)
      end
    end

    def percentage(value, precision = 2)
      if value.nil? || value.zero?
        '-'
      else
        value = 0.00 if value.blank?
        number_to_percentage(value * 100, precision: precision)
      end
    end
    alias_method :decimal_to_percentage, :percentage

    def currency(number, unit: "", separator: ".", delimiter: ",", precision: 2)
      number_to_currency(number, unit: unit,
                                 separator: separator,
                                 delimiter: delimiter,
                                 precision: precision)
    end

    def quantity(number)
      number_with_precision(number.to_f, precision: 2, delimiter: ',')
    end
  end
end

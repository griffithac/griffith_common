module GriffithCommon
  module FormattingHelpers
    def simple_number(number)
      number == number.to_i ? number.to_i : number.round(4)
    end

    def decimal_to_percentage(value, precision)
      value = 0.00 if value.blank?
      number_to_percentage(value * 100, precision: precision)
    end

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

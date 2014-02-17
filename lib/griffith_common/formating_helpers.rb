module GriffithCommon
  module FormatingHelpers

    def currency number
      number_to_currency(number, :unit => "",
                                 :separator => ".",
                                 :delimiter => ",")
    end

  end
end

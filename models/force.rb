class Force
  attr_reader :number_of_soldiers, :attack_power, :defense_power

  def initialize(number_of_soldiers:, attack_power:, defense_power:)
    @number_of_soldiers = number_of_soldiers
    @attack_power = attack_power
    @defense_power = defense_power
  end
end

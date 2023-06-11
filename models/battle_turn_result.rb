class BattleTurnResult
  attr_reader :attacker, :defender, :damage_to_attacker, :damage_to_defender, :remaining_attacker_soldiers, :remaining_defender_soldiers

  def initialize(attacker, defender, previous_turn_result: nil)
    @attacker = attacker
    @defender = defender
    @remaining_attacker_soldiers = previous_turn_result&.remaining_attacker_soldiers || attacker.number_of_soldiers
    @remaining_defender_soldiers = previous_turn_result&.remaining_defender_soldiers || defender.number_of_soldiers
  end

  def run
    @damage_to_attacker = attack_damage(from: defender, to: attacker, remaining_soldiers: @remaining_attacker_soldiers)
    @damage_to_defender = attack_damage(from: attacker, to: defender, remaining_soldiers: @remaining_defender_soldiers)

    @remaining_attacker_soldiers = [@remaining_attacker_soldiers - @damage_to_attacker, 0].max
    @remaining_defender_soldiers = [@remaining_defender_soldiers - @damage_to_defender, 0].max

    self
  end

  private
  def attack_point(force, remaining_soldiers)
    force.attack_power * remaining_soldiers
  end

  def attack_damage(from:, to:, remaining_soldiers:)
    [(attack_point(from, remaining_soldiers).to_f / to.defense_power * 0.1).floor, 1].max
  end
end

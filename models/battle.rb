class Battle
  attr_reader :attacker, :defender, :turn_results, :result_code, :winner, :winner_id, :loser, :loser_id

  def initialize(attacker, defender)
    @attacker = attacker
    @defender = defender
    @turn_results = []
  end

  def run
    while !is_finished(@turn_results.last)
      @turn_results << BattleTurnResult.new(attacker, defender, previous_turn_result: turn_results.last).run
    end

    if is_lose(@attacker, @turn_results.last.remaining_attacker_soldiers)
      @result_code = "failure"
      @winner = @defender
      @loser = @attacker
    else
      @result_code = "success"
      @winner = @attacker
      @loser = @defender
    end

    true
  end

  private
  def is_finished(turn_result)
    return false unless turn_result

    is_lose(attacker, turn_result.remaining_attacker_soldiers) || is_lose(defender, turn_result.remaining_defender_soldiers)
  end

  def is_lose(force, remaining_soldiers)
    remaining_soldiers <= force.number_of_soldiers * 0.1
  end
end

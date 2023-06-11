require "active_support/all"

require "./models/battle"
require "./models/force"
require "./models/battle_turn_result"

attacker = Force.new(
  number_of_soldiers: 52000,
  attack_power: 120,
  defense_power: 82,
)
defender = Force.new(
  number_of_soldiers: 50000,
  attack_power: 80,
  defense_power: 120,
)

battle = Battle.new(attacker, defender)
battle.run

puts "======================================"

battle.turn_results.each.with_index(1) do |result, i|
  puts "ターン#{i}"
  puts "■攻撃側"
  puts "受けたダメージ: #{result.damage_to_attacker}"
  puts "残存兵力: #{result.remaining_attacker_soldiers}"
  puts "■防御側"
  puts "受けたダメージ: #{result.damage_to_defender}"
  puts "残存兵力: #{result.remaining_defender_soldiers}"
  puts "======================================"
end

last_result = battle.turn_results.last

puts battle.result_code


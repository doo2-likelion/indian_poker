require "xmlrpc/server"
require "socket"

s = XMLRPC::Server.new(ARGV[0])
MIN_DEFAULT_BET = 1000

class MyAi
  def calculate(info)
    opposite_play_card = info[0] #상대방이 들고 있는 카드 숫자
    past_cards = info[1]         #지금까지 흘러간 카드 배열
    my_money = info[2]           #내 주머니에 있는 돈
    bet_history = info[3]        #지금 판에 깔린 돈 배열

    your_total_bet, my_total_bet = get_total_bet_money_per_person bet_history
    this_bet = your_total_bet - my_total_bet

    if this_bet == 0
      this_bet = MIN_DEFAULT_BET
    end

    return [this_bet, "debug message"]

    #Codes END
  end


  def get_name
    "MY AI!!!"
  end

  private 
  def get_total_bet_money_per_person bet_history
    bet_history_object = bet_history.clone #Clone Object
    total_bet_money = [0, 0]
    index = 0
    while (bet_history_object.size > 0) do 
      money = bet_history_object.pop
      total_bet_money[0] += money if index.even?
      total_bet_money[1] += money if index.odd?
      index += 1
    end
    total_bet_money
  end

end

s.add_handler("indian", MyAi.new)
s.serve

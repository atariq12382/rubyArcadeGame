class LeaderBoard           # class of leaderboard which is used to manage the leaderboard in accordance to the player's score
    
    def initialize(n, m, ranked, player)            # a class constructor that will take four parameters; 1. n => number of players on leaderboard.
        @n = n                                      # 2. m => total number of games played by the player. 3. ranked => an array consisting of scores
        @m = m                                      # of players on a leaderboard. 4. player => an array of score of games played by the player
        @ranked = ranked
        @player = player
        @playerRank = []                           # it have array that keeps the ranks for the player
        @currentScore = 0                           # it have variable current score that keeps track of which score is bieng added to leaderboard 
        @leaderBoard = []                           # it have another variable leaderboard that stores the leaderboard in the [rank, score] form.
        puts "Initial LeaderBoard"                  # its then calls two methods of the class for further working.
        self.createLeaderBoard
    end
    
    def createLeaderBoard                              # a method that creates leaderboard in accordance to the given ranked array. It first sorts the ranked array
        @ranked.sort! {|x, y| y <=> x}                 # into descending order and it pushes the first rank and score outside the loop and then inside the loop it compares 
        @leaderBoard.clear                             # with the first index and give the scores rank accordingly and in the end it calls another method to print leaderboard.
        @leaderBoard.push([1, @ranked[0]])
        for i in 1..@ranked.length-1 do
            if @leaderBoard[i-1][1] == @ranked[i]
                pos = @leaderBoard[i-1][0]
                @leaderBoard.push([pos, @ranked[i]])
            else
                pos = @leaderBoard[i-1][0]
                pos = pos + 1
                @leaderBoard.push([pos, @ranked[i]])
            end
        end
        self.printLeaderBoard
        for i in 0..@leaderBoard.length-1 do
            if @currentScore == @leaderBoard[i][1]
                @playerRank.push(@leaderBoard[i][0])
                break
            end
        end
    end

    def climbingLeaderBoard                                             # a method that reads the player array index by index and push each score in ranked every iteration and then calls
        @player.sort!                                                  # createLeaderBoard which then again creates leader board accordance to the updated ranked array
        for i in 0..@player.length-1 do
            playerScore = @player[i]
            @ranked.push(playerScore)
            @currentScore = playerScore
            puts "Leader Board After Player's Turn Number : #{i+1}"
            self.createLeaderBoard
            @ranked.delete_at(@ranked.index(playerScore))
        end
        return @playerRank
    end

    def printLeaderBoard                                                   # a method that prints the leaderboard array in this format:
        puts "Rank      Score"                                             # Rank      Score
        for i in 0..@leaderBoard.length-1 do                               # 1         100
            puts "#{@leaderBoard[i][0]}         #{@leaderBoard[i][1]}"
        end
    end
end

constraint1 = 2 * (10**5)                                                  # contsraint that applys on the values of n and m
constraint2 = 10**9                                                        # contsraint that applys on the values of scores in ranked and player

n = 0
loop do                                                                    # Takes input of n from the user and checks if the input is empty or not. if its empty
    puts "Enter the Total Number of Players on the Leader Board:"          # puts error message and ask for input again and if the input is non-empty it checks if 
    temp = gets.chomp                                                      # the input is in the limits then breaks the loop else puts error message and ask for input again
    if temp.empty?
        puts "Error: Input is required"
        next
    end
    n = temp.to_i
    if n >= 1 && n <= constraint1 
        break
    else
        puts "Error: Limit Exceeded for Number of Players"
    end
end

ranked = []                                                                # Takes input of score for ranked n times from the user and checks if the input is empty or not. if its empty
for i in 0..n-1 do                                                         # puts error message and ask for input again and if the input is non-empty it checks if 
    loop do                                                                # the input is in the limits then breaks the loop else puts error message and ask for input again
        puts "Enter the score of Player Number #{i+1}:"
        temp = gets.chomp
        if temp.empty?
            puts "Error: Input is required"
            next
        end
        r = temp.to_i
        if r >= 0 && r <= constraint2
            ranked.push(r)
            break
        else
            puts "Error: Limit Exceeded for Score"
        end
    end
end

m = 0                                                                      # Takes input of n from the user and checks if the input is empty or not. if its empty
loop do                                                                    # puts error message and ask for input again and if the input is non-empty it checks if 
    puts "Enter the Total Number of Games Played by the Player:"           # the input is in the limits then breaks the loop else puts error message and ask for input again
    temp = gets.chomp
    if temp.empty?
        puts "Error: Input is required"
        next
    end
    m = temp.to_i
    if m >= 1 && m <= constraint1 
        break
    else
        puts "Error: Limit Exceeded for Number of Games Played"
    end
end

player = []                                                               # Takes input of score for player m times from the user and checks if the input is empty or not. if its empty
for i in 0..m-1 do                                                        # puts error message and ask for input again and if the input is non-empty it checks if 
    loop do                                                               # the input is in the limits then breaks the loop else puts error message and ask for input again
        puts "Enter the score of player for Game #{i+1}:"
        temp = gets.chomp
        if temp.empty?
            puts "Error: Input is required"
            next
        end
        r = temp.to_i
        if r >= 0 && r <= constraint2
            player.push(r)
            break
        else
            puts "Error: Limit Exceeded for Score"
        end
    end
end

leaderboard = LeaderBoard.new(n, m, ranked, player)                      # creates an object of the class LeaderBoard and pass the values of n, m, ranked, players end
a = leaderboard.climbingLeaderBoard
puts "-------------------------------------"
puts "Game#     Rank     Score"
for i in 0..a.length-1 do
    puts "#{i+1}         #{a[i]}        #{player[i]}"                   # prints score and rank of a player in accordance to the game number.
end
class GameController < ApplicationController
  # This action is for the bare domain. You can ignore it.
  def home
    redirect_to("/mockup.html")
  end

  # Your code goes below.

  def rps
    # Rails, behind the scenes:
    # params = {"move"=>"rock"}

    @user_move = params["the_move"]

    @computer_move = ["rock", "paper", "scissors"].sample

    if @user_move == @computer_move
      @outcome = "tied"
    elsif @user_move == "paper" && @computer_move == "rock"
      @outcome = "won"
    elsif @user_move == "paper" && @computer_move == "scissors"
      @outcome = "lost"
    elsif @user_move == "scissors" && @computer_move == "rock"
      @outcome = "lost"
    elsif @user_move == "scissors" && @computer_move == "paper"
      @outcome = "won"
    elsif @user_move == "rock" && @computer_move == "paper"
      @outcome = "lost"
    elsif @user_move == "rock" && @computer_move == "scissors"
      @outcome = "won"
    end

    #Logic to add a new entry to the move table

    @all_moves = Move.all

    m = Move.new
    m.user_move = @user_move
    m.computer_move = @computer_move

    if @outcome == "won"
        m.tie = 0
        m.user_wins = 1
        m.computer_wins = 0
      elsif @outcome == "lost"
        m.tie = 0
        m.user_wins = 0
        m.computer_wins = 1
      else
        m.tie = 1
        m.user_wins = 0
        m.computer_wins = 0
      end
      m.save

      @user_wins_rock = Move.where(:user_move => "rock").sum(:user_wins)
      @user_wins_paper = Move.where(:user_move => "paper").sum(:user_wins)
      @user_wins_scissors = Move.where(:user_move => "scissors").sum(:user_wins)

      @computer_wins_rock = Move.where(:computer_move => "rock").sum(:computer_wins)
      @computer_wins_paper = Move.where(:computer_move => "paper").sum(:computer_wins)
      @computer_wins_scissors = Move.where(:computer_move => "scissors").sum(:computer_wins)

      @tie_rock = Move.where(:user_move => "rock").sum(:tie)
      @tie_paper = Move.where(:user_move => "paper").sum(:tie)
      @tie_scissors = Move.where(:user_move => "scissors").sum(:tie)

    render("move.html.erb")

  end
end

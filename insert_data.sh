#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE games, teams;")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != "year" ]]
then
# GET winner_id
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
# if not found, insert WINNER
if [[ -z $WINNER_ID ]]
then
INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) values ('$WINNER')")
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
fi
# GET opponent_id
OPPONENT_ID=$($PSQL "SELECT TEAM_ID FROM teams WHERE name='$OPPONENT'")
# If not found, insert opponent
if [[ -z $OPPONENT_ID ]]
then
insert_opponent_result=$($PSQL "insert into teams(name) values('$OPPONENT')")
OPPONENT_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")
fi
# insert game record
insert_game_result=$($PSQL "insert into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) values($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
fi
done
#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
echo $($PSQL "TRUNCATE TABLE games,teams")
# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do 
if [[ $year != 'year' ]]
then
#adding country to file
CHECK=$($PSQL "select * from teams where name = '$winner' ")
if [[ -z $CHECK ]]
then
ADD=$($PSQL "insert into teams(name) values('$winner')")

fi

CHCK=$($PSQL "select * from teams where name = '$opponent' ")
if [[ -z $CHCK ]]
then
ADD=$($PSQL "insert into teams(name) values('$opponent')")

fi
WINNER_ID=$($PSQL "select team_id from teams where name='$winner'")
OPPONENT_ID=$($PSQL "select team_id from teams where name='$opponent'")
 
FINAL=$($PSQL "insert into games(year,round,winner_goals,opponent_goals,winner_id,opponent_id) values($year,'$round',$winner_goals,$opponent_goals,$WINNER_ID,$OPPONENT_ID)")
fi
done
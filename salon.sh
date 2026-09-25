#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only --no-align -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"
MAIN_MENU() {
  if [[ $1 ]]
  then
  echo -e "\n$1"
  fi
  echo "Welcome to My Salon, how can I help you?"
  #Get available services
  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
  #Display services
  echo "$SERVICES" | while IFS="|" read SERVICE_ID NAME
  do
  echo "$SERVICE_ID) $NAME"
  done
  read SERVICE_ID_SELECTED
  #Check is selection is a number and valid service
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_NAME ]]
  then
  MAIN_MENU "I could not find that service. What would you like today?"
  else
  SCHEDULE_APPOINTMENT $SERVICE_ID_SELECTED "$SERVICE_NAME"
  fi
}
SCHEDULE_APPOINTMENT() {
  SERVICE_ID_SELECTED=$1
  SERVICE_NAME=$2
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  #Check if customer exists
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  #If Customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
  echo -e "\nI don't have a record for that phone number, what's your name?"
  read CUSTOMER_NAME
  #Insert new customer
  INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  #Get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone ='$CUSTOMER_PHONE'")
  echo -e "\nWhat time would you like you $SERVICE_NAME, $CUSTOMER_NAME?"
  read SERVICE_TIME
  # Insert appointment
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  #Format output names (remove leading/trailing spaces)
  SERVICE_NAME_FORMATTED=$( echo $SERVICE_NAME | sed 's/^ *//;s/ *$//')
  CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed 's/^ *//;s/ *$//')
  echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATTED."
  }
  MAIN_MENU
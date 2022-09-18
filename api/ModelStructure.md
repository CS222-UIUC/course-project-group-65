
# Model View Structures


## Expense

* add expense (POST)
    * create a new data entry in table
        * get the info from the frontend request (as json i think?)
            * name, category, date, amt, who is suppsed to pay, how much is the split, owner
        * parse the info
            * pretty self expalantory for the expense table
            * for user table, each user gets inputed and then connect each user to the expense created
        * update expenses for specific user as well
        
* update expense (PUT)
    * same thing as add expense, but modifies an already created xpense instead of creating new data entry

* delete expense (DELETE)
    * self explanatory (delete entry in expense table AND associated entries in user expense table)

* pay expense (PUT)
    * w/ the expense id or whatever, you update the paid column for user expense
    * then check if all expenses for that expense id in the user expense table is paid
        if all are paid then change paid column in expense table

* get expense (GET)
    * get info about expense, pretty self explan


## Chore

* add chore (POST)
    * create new entry in the chore table w/ info about the name, ass roomid, and weight
    * asign to least weight user in the room -> update chore weight too.
        aasign algo iwll be something diff


* delete chore (DELETE)
    * delete entry, and update chore weight of the user

* get chore (GET)
    * self explan.

* rotate chores(PUT)
    * self explan.


## Room

* create room(POST)
    * get name, admin_id
    * set chore cycle len to 1 week( 7 days) 
    * set num_members to 1

* add user to room (PUT)
    * update num_memebrs +1
    * update room_id for user table
    * if set_up is false, then assign chores on next cycle
    * if set_up is true, wait.
    * update/set expesnes_amt to 0 amd choreweith to 0;

* delete room (DELETE)
    * update expesnes amt for each user to 0
    * delete room_id for each user
    * delete room

* get room (GET)
    * self explan.

* update chore_cycle (PUT)
    * duh.

* update name (PUT)
    * duh.



## User

* create user (POST)
    * get name, nickname, email and set those
    * set avaiable to yes
    * exp. amoutn t 0
    * roomid to 0 for rn.
    * chorewieght to 0 for rn.

* update user settings functs (PUT)

* delete user (DEETE)
    * duh

* get user (GET)
    * duh




## Memos

* create memo (POST)
    * get info (roomid, text, userid of creator)

* get memo (GET)
    * duh

* delete memo (Duh) 

* update memo (PUT)
    * check if editable
    * if yes then update text


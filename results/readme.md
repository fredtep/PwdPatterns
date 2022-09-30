# Password Pattern

This project came to my mind after reading <a href="https://www.researchgate.net/publication/276113338_Cracking_More_Password_Hashes_With_Patterns" target=_blank> Emin Islam Tath' paper : Cracking more Password Hashes with Patterns.</a> and [this paper](https://www.sciencedirect.com/science/article/pii/S2666281721000949) (sorry, the title is just too long)
The paper was really good but I could see two problem :
* The wordlist used was rockyou which is quite old
* There was no chart on the first paper

The first goal of this project is to get better at password cracking and to see if there are specific pattern to my country.

In order to do so I built a bash script that will find different patterns from a word list and make a JSON file out of it. The JSON files are then taken in a flask app that will generate nice charts for a better understanding.

## In order to play with PasswordPattern

**git clone **
#!/bin/bash


###########################################
#---------------) Colors (----------------#
###########################################

C=$(printf '\033')
CYAN="${C}[0;36m"
LIGHT_MAGENTA="${C}[1;95m"
LIGHT_CYAN="${C}[1;96m"
NC="${C}[0m"

if [ $# -eq 0 ]
    then
        echo "Please add a wordlist"
        echo "$0 <path to wordlist>"
        exit 1
    else 
        PWDFILE=$1
fi

# Make results directory if it does not alreadyexist
[[ ! -d "./results" ]] && mkdir ./results

WORDLIST=$(basename -- $1)
# Carefull, we are removing extension below
WORDLISTNAME=${WORDLIST::-4}

RESULT=$(echo "./results/$WORDLISTNAME.json")

###########################################
#------------) Password list (------------#
###########################################

echo -e "\n${LIGHT_MAGENTA}---------------------------------------------"
echo -e "${LIGHT_MAGENTA} Generating all the good stuff"
echo -e "${LIGHT_MAGENTA}---------------------------------------------\n\n"

echo -e "{" > $RESULT
echo -e "\"PasswordList\":\"$WORDLIST\"," >> $RESULT

# Console Output
echo -e "${CYAN}Password List : ${NC} $WORDLIST\n"

###########################################
#--------) Number of passwords (----------#
###########################################

LENGTH=$(cat $1 | wc -l)

echo "\"NumberOfPasswords\": $LENGTH," >>  $RESULT

# Console Output
echo -e "${CYAN}Number Of Passwords:${NC}$LENGTH\n"


###########################################
#---------) Passwords Length (------------#
###########################################

TABLEAU="["

for i in {1..18}
    do
        eval "LENGTH$i=$(grep -Ea "^.{$i}$" $1 | wc -l)"
        TABLEAU+="['Length : $i',"$(grep -Ea "^.{$i}$" $1 | wc -l)"],"

    done

TABLEAU=${TABLEAU::-1}

# Generate the JSON File
echo "\"Length\":\"$TABLEAU]\"," >> $RESULT
# Console Output
echo -e "${CYAN}Length : ${NC}$TABLEAU]\n"


###########################################
#----------) Basic patterns (-------------#
###########################################

Low=$(grep -Ea "^[a-z]+$" $1 | wc -l)
echo "${CYAN}Low :${NC} $Low"
Up=$(grep -Ea "^[A-Z]+$" $1 | wc -l)
echo "${CYAN}Up :${NC} $Up"
Num=$(grep -Ea "^[0-9]+$" $1 | wc -l)
echo "${CYAN}Num :${NC} $Num"
LowUp=$(grep -Ea "^[A-Za-z]+$" $1 | grep -Eva "^[A-Z]+$" | grep -Eva "^[a-z]+$" | wc -l)
echo "${CYAN}LowUp :${NC} $LowUp"
LowNum=$(grep -Ea "^[a-z0-9]+$" $1 | grep -Eva "^[a-z]+$" | grep -Eva "^[0-9]+$" | wc -l)
echo "${CYAN}LowNum :${NC} $LowNum"
UpNum=$(grep -Ea "^[A-Z0-9]+$" $1 | grep -Eva "^[A-Z]+$" | grep -Eva "^[0-9]+$" | wc -l)
echo "${CYAN}UpNum :${NC} $UpNum"
LowUpNum=$(grep -Ea "^[A-Za-z0-9]+$" $1 | grep -Ea "[0-9]" | grep -Ea "[a-z]" | grep -Ea "[A-Z]" | wc -l)
echo "${CYAN}LowUpNum :${NC} $LowUpNum"
SpecAny=$(grep -Ea "[\!:;,?./§*$&\"\'(-|_^@)=+]" $1 | wc -l)                                                
echo "${CYAN}SpecAny :${NC} $SpecAny"

echo -e "----------------------"
echo "${LIGHT_MAGENTA}Total : ${NC}$(($Low+$Up+$Num+$LowUp+$LowNum+$UpNum+$LowUpNum+$SpecAny))"
# Generate the JSON File
echo "\"Pattern\":\"[['LowNum : ',$LowNum],['Low : ',$Low],['Num : ',$Num],['SpecAny : ',$SpecAny],['Up : ',$Up],['LowUp : ',$LowUp],['UpNum : ',$UpNum],['LowUpNum : ',$LowUpNum]]\"," >> $RESULT


###########################################
#----------) Low Num patterns (-----------#
###########################################


LowerNum=$(grep -Ea "^[a-z]+[0-9]+$" $1 | wc -l)
NumLower=$(grep -Ea "^[0-9]+[a-z]+$" $1 | wc -l)
RestLowNum=$(($LowNum-($LowerNum+$NumLower)))


# Generate the JSON File
echo "\"LowNumPattern\":\"[['LowerNum : ',$LowerNum],['NumLower : ',$NumLower],['RestLowNum : ',$RestLowNum]]\"," >> $RESULT

echo $restLowNum

LowerN=$(grep -Ea "^[a-z]+[0-9]{1}$" $1 | wc -l)
LowerNN=$(grep -Ea "^[a-z]+[0-9]{2}$" $1 | wc -l)
LowerNNN=$(grep -Ea "^[a-z]+[0-9]{3}$" $1 | wc -l)
LowerNNNN=$(grep -Ea "^[a-z]+[0-9]{4}$" $1 | wc -l)
LowerNNNNN=$(grep -Ea "^[a-z]+[0-9]{5}$" $1 | wc -l)
LowerNNNNNN=$(grep -Ea "^[a-z]+[0-9]{6}$" $1 | wc -l)
LowerNNNNNNN=$(grep -Ea "^[a-z]+[0-9]{7}$" $1 | wc -l)

echo -e "${CYAN}Generating Lower + xN \n"

# Generate the JSON File
echo "\"LowerN\":\"[['LowerN :',$LowerN],['LowerNN :',$LowerNN],['LowerNNN :',$LowerNNN],['LowerNNNN :',$LowerNNNN],['LowerNNNNN :',$LowerNNNNN],['LowerNNNNNN :',$LowerNNNNNN],['LowerNNNNNNN :',$LowerNNNNNNN]]\"," >> $RESULT



###########################################
#-------) Special chars patterns (--------#
###########################################

echo -e "${CYAN}Generating special characters password patterns \n"

OnlySpec=$(grep -Ea "^[\!:;,?./§*$&\"\'(-|_^@)=+]*$" $1 | wc -l)
echo "${CYAN}OnlySpec :${NC} $OnlySpec"
UpSpec=$(grep -Ea "[\!:;,?./§*$&\"\'(-|_^@)=+]" $1 | grep -vaE "[0-9]" | grep -vaE "[a-z]" | grep -vaE "^[\!:;,?./§*$&\"\'(-|_^@)=+]+$" |  wc -l)
echo "${CYAN}UpSpec :${NC} $UpSpec"
LowSpec=$(grep -Ea "[\!:;,?./§*$&\"\'(-|_^@)=+]" $1 | grep -vaE "[0-9]" | grep -vaE "[A-Z]" | grep -vaE "^[\!:;,?./§*$&\"\'(-|_^@)=+]+$" | wc -l)
echo "${CYAN}LowSpec :${NC} $LowSpec"
LowNumSpec=$(grep -Ea "[\!:;,?./§*$&\"\'(-|_^@)=+]" $1 | grep -Ea "[0-9]" | grep -Ea "[a-z]" | grep -vaE "[A-Z]" | grep -vaE "^[\!:;,?./§*$&\"\'(-|_^@)=+]+$" | wc -l)
echo "${CYAN}LowNumSpec :${NC} $LowNumSpec"
UpNumSpec=$(grep -Ea "[\!:;,?./§*$&\"\'(-|_^@)=+]" $1 | grep -Ea "[0-9]" | grep -Ea "[A-Z]" | grep -vaE "[a-z]" | grep -vaE "^[\!:;,?./§*$&\"\'(-|_^@)=+]+$" | wc -l)
echo "${CYAN}UpNumSpec :${NC} $UpNumSpec"
LowUpNumSpec=$(grep -Ea "[\!:;,?./§*$&\"\'(-|_^@)=+]" $1 | grep -Ea "[0-9]" | grep -Ea "[A-Z]" | grep -Ea "[a-z]" | grep -vaE "^[\!:;,?./§*$&\"\'(-|_^@)=+]+$" | wc -l)
echo "${CYAN}LowUpNumSpec :${NC} $LowUpNumSpec"

echo -e "----------------------"
echo "${LIGHT_MAGENTA}Total : ${NC}$(($OnlySpec+$UpSpec+$LowSpec+$LowNumSpec+$UpNumSpec+$LowUpNumSpec))"

echo "\"SpecAny\":\"[['OnlySpec :',$OnlySpec],['UpSpec :',$UpSpec],['LowSpec :',$LowSpec],['LowNumSpec :',$LowNumSpec],['UpNumSpec :',$UpNumSpec],['LowUpNumSpec :',$LowUpNumSpec]]\"" >> $RESULT


# Console Output
echo "${LIGHT_MAGENTA}Done! Enjoy"

echo -e "}" >> $RESULT
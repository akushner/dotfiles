# fuck.bash --- fuck user over
# Author: unknown
# Adapted by: Noah Friedman <friedman@prep.ai.mit.edu>
# Created: 1991-06-18
# Last modified: 1993-09-29
# Public domain

# Commentary:

# I have no idea where this came from, but it seemed interesting.
# I made a few modifications to the original.

# Code:

###;;;autoload
function fuck ()
{
    case "${1}" in
       "" )
          echo "Fuck *yourself*, asshole."
         ;;
       you )
          case "${2}" in
             "" )
                echo "Don't you like fucking humans?"
               ;;
             * ) 
                echo "You're calling *me* a ${2}?"
               ;;
          esac
         ;;
       me )
          case "${2}" in
             "" )
                echo -n "Removing all your files..."
                sleep 5
                echo "Done."
               ;;
             very )
                case "${3}" in
                   hard )
                      echo -n "Searching the network for a Cray to seriously fuck with you..."
                      sleep 2
                      echo -n -e "\nHold on, this'll be good..."
                      sleep 3
                      echo -e "\nCan't find a Cray on this net.  You luck out."
                     ;;
                   *)
                      echo "Yes, your \`${3}' is very fucked."
                     ;;
                esac
               ;;
             harder )
                echo -n "Removing all your files across the network..."
                sleep 7
                echo "Done."
               ;;
             well )
                echo -e "Mailing to all users on this net:\n"
                echo "  \"I've just had a sex-change operation and"
                echo '   would like to check the new equipment.'
                echo '   Volunteers please send me mail."'
               ;;
             terribly )
                case "${3}" in
                   "" )
                     echo -e 'Mailing to all users on this net:\n'
                     echo '  "I would really like to have wild'
                     echo '   sex with your pets and house plants.'
                    ;;
                   well )
                     echo "Sorry, I don't have enough IO processors for that."
                    ;;
                   hard )
                     echo "Sorry, this isn't a Cray."
                    ;;
                   * )
                     echo "You'd like that, wouldn't you?"
                    ;;
                esac
               ;;
             badly )
                echo -e 'Mailing to all users on this net:\n'
                echo '  "I need inflatable sheep for my sexual needs.'
                echo '   Can you tell me where I might find some?"'
               ;;
             green )
                echo "I just happen to know this farmer with a horse that"
                echo "really needs something to fuck... Want the number?"
               ;;
             * )
                if [ ${EUID} -ne 0 ]; then
                   echo "Must be super-user to get fucked that way."
                else
                   echo "Your wish is my command..."
                   echo "${RANDOM}"
                fi
               ;;
           esac
          ;;
       * )
           echo -n "Fucking ${1}..."
           sleep 3
           echo "Done."
           echo "${1} was truly well fucked."
          ;;
    esac
    echo 
}

provide fuck

# fuck.bash ends here

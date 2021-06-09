#!/bin/bash
#this is just pre-defined functions and a .
pointer=0
tape=( 0 0 0 0 0 0 0 0 )
:>.wn
mp(){ #Move Pointer
	case $1 in
		"a")
		#absolute move
		#just goes to a cell regardless of position
		pointer=$2
		;;
		"r")
		#relative move
		#just add/subtract from the pointer
		case $3 in
			"+")
			((pointer+=$4))
			;;
			"-")
			((pointer-=$4))
			;;
		esac
		;;
	esac
}

rt(){ #Read Tape
	case $1 in
		"0")
		echo -n "${tape[$pointer]}"
		;;
		"1")
		echo -n "${tape[@]}"
		;;
	esac
}

wt(){ #Write Tape
	case $1 in
		"a")
		#absolute write
		#sets it to $3 value
		case $2 in
			"+")
			tape[$pointer]=$3
			;;
			"-")
			tape[$pointer]=-$3
			;;
		esac
		;;
		"r")
		case $2 in
			"+")
			tape[$pointer]=$((${tape[$pointer]}+$3))
			;;
			"-")
			tape[$pointer]=$((${tape[$pointer]}-$3))
			;;
		esac
		;;
	esac
}

bo(){ #Bit Operation
	case $1 in
		"and")
		((tape[$pointer]&=$2))
		;;
		"or")
		((tape[$pointer]|=$2))
		;;
		"xor")
		((tape[$pointer]^=$2))
		;;
	esac
}

ri(){ #Read Input
      #0 - read 1 digit and write it as a value
      #1 - read 1 byte and write its ascii value
	case $1 in
		"0")
		read -ern 1 input
		tape[$pointer]="$input"
		input=''
		;;
		"1")
		set -x
		read -ern 1 input
		input="$(tr -d '\n'<<<"$input")"
		input="$(echo -n "$input"|tr -d '\n'|xxd -u -p)"
		input="$(bc<<<'ibase=G;obase=A;'$input)"
		tape[$pointer]="$input"
		input=''
		set +x
		;;
	esac
}

cm(){ #CoMpare
      #<, >, =, !=
	case $1 in
		"=")
		[ "${tape[$pointer]}" = "$2" ];tape[$pointer]=$?
		;;
		"!=")
		[ "${tape[$pointer]}" != "$2" ];tape[$pointer]=$?
		;;
		">")
		[ "${tape[$pointer]}" -gt "$2" ];tape[$pointer]=$?
		;;
		"<")
		[ "${tape[$pointer]}" -lt "$2" ];tape[$pointer]=$?
		;;
	esac
}

em(){ #Extra Math
      #**, %, *, /
	case $1 in
		"**")
		tape[$pointer]=$((${tape[$pointer]}**$2))
		;;
		"%")
		tape[$pointer]=$((${tape[$pointer]}%$2))
		;;
		"*")
		tape[$pointer]=$((${tape[$pointer]}*$2))
		;;
		"/")
		tape[$pointer]=$((${tape[$pointer]}/$2))
		;;
	esac
}

rb(){ #Read Binary
	bc<<<"ibase=A;obase=G;${tape[$pointer]}"|sed -e:a -e's/^.\{1,1\}$/0&/;ta'|tail -c3|xxd -p -r
}

pt(){ #Print Text
	printf "%b" "$1"
}

sv(){ #Save Value
	case $1 in
		"tape")
		tape_s=( ${tape[@]} )
		;;
		"pointer")
		pointer_s=$pointer
		;;
	esac
}

lv(){ #Load Value
	case $1 in
		"tape")
		tape=( ${tape_s[@]} )
		;;
		"pointer")
		pointer=$pointer_s
		;;
	esac
}

np(){
	: #NOP
}

cl(){ #CaLl
	. $1
}

wn(){ #While Not
      #do something (as $2 arg, separate by ';', '&&', or other valid bash separators
	echo "$2" > .wn
	while [ "${tape[$pointer]}" != "$1" ];do
		. .wn
	done
}

. $1

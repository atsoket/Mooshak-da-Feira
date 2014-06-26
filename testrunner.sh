#!/bin/bash

filename=$1

if $1; then
	echo 'Ficheiro que queres compilar: (ex: asa.cpp ou oMeuFicheiroLindo.c) '
	read filename
else
	filename=$1
fi

s=0
passados=0
falhados=0

if find $filename; then

	if grep system $filename; then
	        echo "Deixa de ser parvo, isto foi criado para ajudar o pessoal"
		rm *.c*
	        exit -1;
	        echo "eheheheh"
	fi
	
        if grep "fork" $filename; then
		echo "Deixa de ser parvo, isto foi criado para ajudar o pessoal"
                rm *.c*
                exit -1;
        fi

        if grep "sys/*" $filename; then
		echo "Deixa de ser parvo, isto foi criado para ajudar o pessoal"
		rm *.c*
		exit -1;
	fi
	if grep "fcntl" $filename; then
                echo "Deixa de ser parvo, isto foi criado para ajudar o pessoal"
                rm *.c*
                exit -1;
        fi

	if grep "errno.h" $filename; then
                echo "Deixa de ser parvo, isto foi criado para ajudar o pessoal"
                rm *.c*
                exit -1;
        fi
	if grep "signal.h" $filename; then
                echo "Deixa de ser parvo, isto foi criado para ajudar o pessoal"
                rm *.c*
                exit -1;
        fi
	
	if grep "csignal" $filename; then
                echo "Deixa de ser parvo, isto foi criado para ajudar o pessoal"
                rm *.c*
                exit -1;
        fi

	if grep "linux/*" $filename; then
                echo "Deixa de ser parvo, isto foi criado para ajudar o pessoal"
                rm *.c*
                exit -1;
        fi
	
	if  [[ $filename == *.cpp ]] ; then
		if g++ -O3 -ansi -Wall $filename -lm -o proj; then
			s=1
		else
			s=-1
		fi
	else
		if  [[ $filename == *.c ]] ; then
			if gcc -O3 -ansi -Wall $filename -lm -o proj; then
				s=1
			else
				s=-1
			fi
		else
			echo 'Ficheiro com extensão diferente de .c ou .cpp'
		fi
	fi


	if [ "$s" -eq 1 ]; then
		echo '<html> 	<head > 		<title>Mooshak da Feira</title> 		<link href="images/mooshak-16.png" rel="icon" type="image/x-icon" /> 		<meta http-equiv="content-type" content="text/html; charset=utf-8" /> 		<meta name="description" content="" /> 		<meta name="keywords" content="" /> 		<link href="http://fonts.googleapis.com/css?family=Open+Sans:300,600,700" rel="stylesheet" /> 		<script src="js/jquery.min.js"></script> 		<script src="js/config.js"></script> 		<script src="js/skel.min.js"></script> 		<noscript> 			<link rel="stylesheet" href="css/skel-noscript.css" /> 			<link rel="stylesheet" href="css/style.css" /> 			<link rel="stylesheet" href="css/style-desktop.css" /> 		</noscript> 	</head> 	<body align="center">  		<!-- Nav --> 			<nav id="nav"> 				<ul class="container"> 					<li><a href="http://web.ist.utl.pt/~daniel.da.costa/MooshakFeira/">Início</a></li> 					<li><a href="http://web.ist.utl.pt/~daniel.da.costa/MooshakFeira/#Perceber">Perceber</a></li> 					<li><a href="http://web.ist.utl.pt/~daniel.da.costa/MooshakFeira/#Submeter">Submeter</a></li> 				</ul> 			</nav>  			<div class="wrapper wrapper-style2" align="center"> 				<article id="Perceber" align="center"> 					<h1>Resultados</h1>  					<style> 					 					 					</style>  					    <table class="center"> 					      <tr> 						<th>Teste</th> 						<th>Resultado</th> 						<th>Tempo</th> 					      </tr> '

		for file_in in tests/*.in 
		do
			file_out=${file_in//.in/.out}
			file_expected=${file_in//.in/.expected}
			file_diff=${file_in//.in/.diff}

			testname=${file_in//.in/}
			testname=${testname//test/}

			
			echo "<tr><td> $testname </td>";
			/usr/bin/time -f "%e" timeout 9 ./proj < $file_in > $file_out 2>tempo.time
			#time ./proj < $file_in > $file_out

			timmer=$(head -n 1 tempo.time)

			 
			if diff $file_out $file_expected > $file_diff; then
			echo '<td align="center"> <img src="certo.jpg"> </td>';
	                echo "<td>  $timmer </td></tr>";
			
				#echo 'Test passed!!! in $timmer s'
				rm $file_diff
				rm $file_out
				passados=$[passados+1]
			else
				echo '<td  align="center"> <img src="errado.jpg"> </td>';
	                	echo "<td>  $timmer </td></tr>";
				rm $file_diff
				rm $file_out
				#mv $file_diff .
				#mv $file_out .
				falhados=$[falhados+1]
			fi

		done
		rm proj


echo ' </table> '
	echo '			</article>'
	echo '		</div>'
		echo '			<footer>'
		echo '				<ul id="copyright">'
		echo '					<li>&copy; 2014 Daniel da Costa</li>'
			echo '				<li>Design: <a href="http://html5up.net/">HTML5 UP</a></li><br>'
				echo '			Gerador de testes por Bruno Oliveira'
				echo '		</ul>'
				echo '	</footer>'
				echo '</article>'
			echo '</div>'
	echo '</body>'
echo '</html>'

		
	else
		echo 'Compile Time Error :('
	fi
else
	echo '+-----------------------------+'
	echo "| Ficheiro não encontrado :'( |"
	echo '+-----------------------------+'
fi

rm *.c*
rm *.time

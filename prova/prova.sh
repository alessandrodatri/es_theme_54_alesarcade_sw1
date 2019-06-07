#!/bin/bash

# Script By tanstaafl (italian version By AleSArcade)
dialog --backtitle "Pulizia lista ultimi giochi eseguiti e contatori" --title "Pulizia lista ultimi giochi eseguiti e contatori" \
--infobox "

Grazie a questo script sarà possibile pulire la lista degli
ultimi giochi eseguiti (lastplayed) e i loro contatori." 17 55
sleep 5
INPUT=/tmp/played.sh.$$
dialog --backtitle "Pulizia lista ultimi giochi eseguiti e contatori" \
--title "Pulizia lista ultimi giochi eseguiti e contatori" \
--default-item 3 \
--ok-label Applica \
--cancel-label Esci \
--menu " Selezionare il percorso in cui sono presenti file gamelist.xml (su / giù) e premere A per confermare." 17 55 4 \
   1 "Percorso home/pi/RetroPie/roms"\
   2 "Percorso opt/retropie/configs"\
   3 "Eseguire entrambi i percorsi 1 e 2"\
   4 "Esci" 2>"${INPUT}"
menuitem=$(<"${INPUT}")
case $menuitem in
  1) #roms
sudo killall emulationstation
for f in /home/pi/RetroPie/roms/**/gamelist.xml
do
echo "file: $f"
grep -e lastplayed -e playcount -v $f > "$f.tmp"
mv -f "$f.tmp" $f
done
echo "realizado en roms**"
for f in /home/pi/RetroPie/roms/ports/**/gamelist.xml
do
echo "file: $f"
grep -e lastplayed -e playcount -v $f > "$f.tmp"
mv -f "$f.tmp" $f
done
echo "realizado en ports"
sleep 2 ;
    dialog --infobox "

       OPERAZIONE ESEGUITA CORRETTAMENTE

  Questo messaggio verrà chiuso tra 3 secondi 
         e il sistema sarà riavviato" 17 55 ;
sleep 3 ;
sudo reboot ;
exit;;
  2) #opt
sudo killall emulationstation
for f in /opt/retropie/configs/all/emulationstation/gamelists/**/gamelist.xml
do
echo "file: $f"
grep -e lastplayed -e playcount -v $f > "$f.tmp"
mv -f "$f.tmp" $f
done
sleep 2;
    dialog --infobox "

       OPERAZIONE ESEGUITA CORRETTAMENTE

  Questo messaggio verrà chiuso tra 3 secondi 
         e il sistema sarà riavviato" 17 55 ;
sleep 3 ;
sudo reboot ;
exit;;
  3) #1y2
sudo killall emulationstation
for f in /home/pi/RetroPie/roms/**/gamelist.xml
do
echo "file: $f"
grep -e lastplayed -e playcount -v $f > "$f.tmp"
mv -f "$f.tmp" $f
done
echo "realizado en home /home/pi/RetroPie/roms/**/gamelist.xml"
sleep 2
for f in /opt/retropie/configs/all/emulationstation/gamelists/**/gamelist.xml
do
echo "file: $f"
grep -e lastplayed -e playcount -v $f > "$f.tmp"
mv -f "$f.tmp" $f
done
echo "realizado en opt /opt/retropie/configs/all/emulationstation/gamelists/**/gamelist.xml"
sleep 2
for f in /home/pi/RetroPie/roms/ports/**/gamelist.xml
do
echo "file: $f"
grep -e lastplayed -e playcount -v $f > "$f.tmp"
mv -f "$f.tmp" $f
done
echo "realizado en ports"
sleep 2;
    dialog --infobox "

       OPERAZIONE ESEGUITA CORRETTAMENTE

  Questo messaggio verrà chiuso tra 3 secondi 
         e il sistema sarà riavviato" 17 55 ;
sleep 3 ;
sudo reboot ;
exit;;
  4) clear; exit 0;;
esac
import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

Main.embed(document.getElementById('root'));

registerServiceWorker();

// Lors du clic du boutton alerte
 function coloration(bouton_alerte){
     var mousedown = false; // On initialise l'état de la souris
     document.getElementById(boutton_alerte).onmousedown = function(){
         mousedown = true; // à true tant que le bouton de la souris est maintenu enfoncé
         // Ta fonction pour colorer la case avec onmouseover
     }
     document.getElementById(boutton_alerte).onmouseup = function(){
         mousedown = false; // Le bouton de la souris n'est plus enfoncé
     }
}

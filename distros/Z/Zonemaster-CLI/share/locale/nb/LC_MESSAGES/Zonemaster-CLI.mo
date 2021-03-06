��    ;      �  O   �            	     *  X   <     �     �  
   �     �  �   �  �   Q  Y   �  t   8     �     �     �      �  3   �  :     O   R  a   �  f   	  f   k	     �	  4   �	  
   
  "   
     :
     V
  K   s
  	   �
     �
     �
  (   �
       <     7   L  0   �  )   �  '   �  >     5   F     |  N   �  G   �  ;   +  (   g     �  #   �     �  "  �  ?   �  %   <  +   b  f   �  C   �     9  \   A  [   �  ^   �    Y  '   u     �  \   �       	     
         +  �   9  R   �  O     |   ]     �     �     �  "   �  =     1   N  @   �  S   �  a     b   w     �     �     �           (     B  G   \  
   �     �     �  -   �     �  A   �  D   ;  C   �  ;   �  8      :   9  7   t     �  A   �  8     -   @     n     �  #   �  	   �  �   �  G   �  )   �  $   )  m   N  F   �       l     h   y  k   �     0   4       6       !   ,   "         *      1                      &   -       .          :      
      #         +       	       )   9                 3         $                %                                  5       (   /   ;             7            2       '   8              

   Level	Number of log entries %8s	%5d entries.
 --level must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG, DEBUG2 or DEBUG3.
 ======= =======  =========  ============  A name/ip string giving a nameserver for undelegated tests, or just a name which will be looked up for IP addresses. Can be given multiple times. As soon as a message at this level or higher is logged, execution will stop. Must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO or DEBUG. At the end of a run, print a summary of the times the zone's name servers took to answer. Boolean flag for activity indicator. Defaults to on if STDOUT is a tty, off if it is not. Disable with --noprogress. CRITICAL DEBUG ERROR Failed to recognize stop level ' Flag indicating if output should be in JSON or not. Flag indicating if output should be streaming JSON or not. Flag indicating if output should be translated to human language or dumped raw. Flag indicating if streaming JSON output should include the translated message of the tag or not. Flag to permit or deny queries being sent via IPv4. --ipv4 permits IPv4 traffic, --no-ipv4 forbids it. Flag to permit or deny queries being sent via IPv6. --ipv6 permits IPv6 traffic, --no-ipv6 forbids it. INFO Instead of running a test, list all available tests. Level      Loading configuration from {path}. Loading policy from {path}. Loading profile from {path}. Local IP address that the test engine should try to send its requests from. Looks OK. Message Module        Must give the name of a domain to test.
 NOTICE Name of a file to restore DNS data from before running test. Name of a file to save DNS data to after running tests. Name of configuration file to load. (TERMINATED) Name of policy file to load. (TERMINATED) Name of profile file to load. (DEFAULT) Name of the character encoding used for command line arguments Print a count of the number of messages at each level Print level on entries. Print the effective configuration used in JSON format, then exit. (TERMINATED) Print the effective policy used in JSON format, then exit. (TERMINATED) Print the effective profile used in JSON format, then exit. Print the name of the module on entries. Print timestamp on entries. Print version information and exit. Seconds  Specify test to run. Should be either the name of a module, or the name of a module and the name of a method in that module separated by a "/" character (Example: "Basic/basic1"). The method specified must be one that takes a zone object as its single argument. This switch can be repeated. Strings with DS data on the form "keytag,algorithm,type,digest" TERMINATED, use dump_profile instead. The locale to use for messages translation. The minimum severity level to display. Must be one of CRITICAL, ERROR, WARNING, NOTICE, INFO or DEBUG. Use of config and policy have been TERMINATED, use profile instead. WARNING Warning: Zonemaster::LDNS not compiled with libidn, cannot handle non-ASCII names correctly. Warning: setting locale category LC_CTYPE to %s failed (is it installed on this system?).

 Warning: setting locale category LC_MESSAGES to %s failed (is it installed on this system?).

 Project-Id-Version: 0.0.5
Report-Msgid-Bugs-To: 
PO-Revision-Date: 2020-08-05 09:46+0200
Last-Translator: Richard Persson <richard.persson@norid.no>
Language-Team: Zonemaster Team
Language: nb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
 

   Nivå         Antall loggmeldinger %8s	%5d meldinger.
 --level må være en av CRITICAL, ERROR, WARNING, NOTICE, INFO, DEBUG, DEBUG2 eller DEBUG3.
 ======= ========  =========  ============  Et navn/IP-nummer for en navnetjener for udelegerte tester eller bare et navn som blir slått opp i DNS. Kan angis flere ganger. Avslutt testkjørningen når en melding med denna nivå eller høyere registreres. Etter kjøring, skriv ut en oppsummering av svarstider fra sonens navnetjenere. Flagg som angir om fremdriftsindikator skal vises. Normalt på dersom STDOUT er en tty, ellers av. Slå av med --noprogress. KRITISK DEBUG FEIL Kunne ikke gjenkjenne stop-nivå ' Flagg som indikerer om output skal være formattert som JSON. Flagg som indikerer om output skal strømme JSON. Flagg som indikerer om output skal oversettes til vanlig språk. Flag som indikerer om strømmet JSON output skal inneholde den oversatte meldingen. Flagg som angir om spørringer skal sendes vha. IPv4. "--ipv4" slår på og "--no-ipv4" slår av. Flagg som angir om spørringer skal sendes vha. IPv6. "--ipv6" slår på og "--no-ipv6" slår av.< INFO Liste tilgjengelige tester. Nivå       Laster konfigurasjon fra {path}. Laster policy fra {path}. Laster profil fra {path}. Lokal IP-adresse som testmotoren skal bruke for å sende meldinger fra. Ser OK ut. Melding Modul         Må angi navnet på domenet som skal testes.
 NOTIS Filnavn på fil med DNS-data som leses inn innen testene startes. Filnavn på fil der DNS-data blir lagret etter at testene er kjørt. Filnavn på fil med konfigurasjonsdata som skal leses. (DEPRECATED) Filnavn på fil med policydata som skal leses. (DEPRECATED) Filnavn på fil med profildata som skal leses. (DEFAULT) Navn på tegnsett som er brukt for kommandolinjeargumenter Skriv en summering av antall meldinger på hvert nivå. Skriv nivå på innslag. Skriv ut konfigurasjoene som er brukt i JSON-format. (DEPRECATED) Skriv ut policy som er brukt i JSON-format. (DEPRECATED) Skriv ut profilen som er brukt i JSON-format. Skriv modulnavn på innslag. Skriv tidsstempel på innslag. Vis versjonsinformasjon og avslutt. Sekunder  Angi test som skal kjøres. Kan angis som "modulnavn" eller "modulnavn/metode". Eksempel: "Basic/basic1". Den angitte metoden må være en som bare tar et sone-objekt som argument. Denne parameteren kan angis flere ganger. En tekststreng med DS-data på formatet: "keytag,algorithm,type,digest" DEPRECATED. Bruk dump_profile istedenfor. Språk for oversetting av meldinger. Minimumsnivå på feilmeldinger. Må være satt til en av CRITICAL, ERROR, WARNING, NOTICE, INFO eller DEBUG. Bruk av konfigurasjon og policy er DEPRECATED. Bruk profil istedenfor. ADVARSEL Advarsel: Zonemaster::LDNS er ikke kompilert med libidn som gir IDNA-støtte. Kan bare håndtere ASCII-navn. Advarsel: misslyktes med at sette locale category LC_CTYPE til %s. Er den installert på dette system?

 Advarsel: misslyktes med at sette locale category LC_MESSAGES til %s. Er den installert på dette system?

 
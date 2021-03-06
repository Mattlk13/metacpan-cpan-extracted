��          �      \      �     �  	   �     �       ?     	   O     Y  +   ^  &   �  k   �       �  *     �  p   �  D   M  0   �  �   �     Q     Y  {  a  #   �  	               >      	   _     i  8   m  -   �  b   �     7	  �  H	  %   B  {   h  N   �  :   3  �   n          	                                                
                            	                       '*' denotes required arguments Arguments Description Examples For more information on transaction, see L<Rinci::Transaction>. Functions Name Pass -dry_run=>1 to enable simulation mode. Pass -reverse=>1 to reverse operation. Required if you pass -undo_action=>'undo'. For more details on undo protocol, see L<Rinci::function::Undo>. Return value Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (result) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information. This function dies on error. This function is idempotent (repeated invocations with same arguments has the same effect as single invocation). This function is immutable (returns same result for same arguments). This function is pure (produce no side effects). To undo, pass -undo_action=>'undo' to function. You will also need to pass -undo_data. For more details on undo protocol, see L<Rinci::Undo>. Version default Project-Id-Version: Perinci-Sub-To-Text 0.30
Report-Msgid-Bugs-To: stevenharyanto@gmail.com
POT-Creation-Date: 2013-12-12 16:35+0700
PO-Revision-Date: 2013-12-12 12:31+0700
Last-Translator: Automatically generated
Language-Team: none
Language: fr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=2; plural=(n > 1);
 '*' désigne arguments nécessaires Arguments Description Examples En savoir plus sur la transaction, voir L<Rinci::Transaction>. Fonctions Nom Passez -dry_run=>1 pour l'opération en mode simulation. Passez -reverse=>1 pour l'opération inverse. nécessaire si vous passez x -undo_action=>'undo'. En savoir plus, voyez L<Rinci::function::Undo>. Valeur de retour Retourner un résultat enveloppé (un tableau).

Premier élément (status) est un entier contenant le code d'état HTTP
(200 moyens OK, erreur de l'appelant 4xx, erreur de fonction 5xx). Second élément
(msg) est un message d'erreur contenant des cordes, ou 'OK' si l'état est
de 200. Troisième élément (résultat) est facultative, le résultat réel. Quatrième
élément (méta) est appelée méta-données du résultat et est facultatif, un hachage
qui contient des informations supplémentaires. Cette fonction meurt en cas d'erreur. Cette fonction est idempotent (invocations répétées ayant les mêmes arguments ont le même effet que seule invocation). Cette fonction est immuable (retourner même résultat pour mêmes arguments). Cette fonction est pure (produire aucun effet secondaire). Pour annuler, passez -undo_action=>'undo' à la fonction. vous aurez également besoin de passer -undo_data. En savoir plus, voyez L<Rinci::Undo>. Version défaut 